#!/usr/bin/env python3

# Created by: samdc73 (github | twitter | samdc73.com)
# GitHub repo for other scripts: github.com/SamDc73/scripts
# Brief:  easier way to uppload larg codebase files to chatgpt

import os
import re
import argparse
from tqdm import tqdm
from multiprocessing import Pool


def process_file(file_path):
    try:
        with open(file_path, "r", encoding="utf-8") as input_file:
            content = input_file.read()
        return file_path, content, None
    except UnicodeDecodeError:
        return (
            file_path,
            None,
            "Failed to decode the file, as it is not saved with UTF-8 encoding.",
        )


def generate_tree_structure(paths):
    tree_lines = []
    for path in paths:
        if os.path.isfile(path):
            tree_lines.append(os.path.basename(path))
        elif os.path.isdir(path):
            for root, dirs, files in os.walk(path):
                level = root.replace(path, "").count(os.sep)
                indent = " " * 4 * level
                tree_lines.append("{}{}/".format(indent, os.path.basename(root)))
                subindent = " " * 4 * (level + 1)
                for f in files:
                    tree_lines.append("{}{}".format(subindent, f))
    return "\n".join(tree_lines)


def write_content_to_file(input_paths, output_file_name, exclude=[]):
    total_files = 0
    copied_files = 0

    tree_structure = generate_tree_structure(input_paths)

    file_list = []
    for path in input_paths:
        if os.path.isfile(path):
            file_list.append(path)
        elif os.path.isdir(path):
            for root, _, files in os.walk(path):
                for file in files:
                    file_path = os.path.join(root, file)
                    exclude_file = any(re.search(ex, file_path) for ex in exclude)
                    if not exclude_file:
                        file_list.append(file_path)

    with open(output_file_name, "w", encoding="utf-8") as output_file:
        output_file.write(tree_structure + "\n\n")
        with Pool() as pool:
            results = list(
                tqdm(
                    pool.imap(process_file, file_list),
                    total=len(file_list),
                    desc="Progress",
                    unit="file",
                )
            )

        for result in results:
            total_files += 1
            if result[1] is not None:
                file_name_line = f"### {result[0]} ###\n"
                output_file.write(file_name_line)
                output_file.write(result[1] + "\n")
                end_line = f"--- End of file: {result[0]} ---\n"
                output_file.write(end_line)
                copied_files += 1
            if result[2] is not None:
                output_file.write(f"{result[0]}\n{result[2]}\n")

    return total_files, copied_files


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert folder contents or specific files to text file."
    )
    parser.add_argument(
        "-i",
        "--input",
        nargs="+",
        default=["."],
        help="Paths to input files or directories (default: current directory)",
    )
    parser.add_argument(
        "-o",
        "--output",
        default="output",
        help="Name of the output file without .txt extension (default: output)",
    )
    parser.add_argument(
        "-e", "--exclude", nargs="*", default=[], help="Files or folders to exclude"
    )

    args = parser.parse_args()

    input_paths = args.input
    output_file_name = args.output + ".txt"

    # Default exclusions
    exclude = [
        r"node_modules/",
        r"\.git/",
        r"build",
        r"test",
        r"\.gitignore",
        r"\.ds_store",
        r"\.jpg$",
        r"\.png$",
        r"\.svg$",
        r"database/",
        r"aider.*",
        r"__pycache__/",
        r"\.bin$",
        r"\.sqlite$",
        r"\.toml$"
    ]
    # Add user-specified exclusions
    exclude.extend([re.escape(item) for item in args.exclude])

    total_files, copied_files = write_content_to_file(
        input_paths, output_file_name, exclude
    )

    print(f"There are a total of {total_files} files in the specified paths.")
    print(f"{copied_files} files were successfully copied to {output_file_name}.")
