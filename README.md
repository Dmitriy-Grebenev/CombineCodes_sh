
# Combine Codes Script

A simple yet powerful Bash script that recursively collects source code and text files from a directory tree and merges them into a single output file. Each file's content is prefixed with a header line containing its relative path, making it easy to review, share, or feed into LLMs (like ChatGPT, Claude, etc.) for code analysis or documentation.

## Features

- **Recursive scanning** – finds all files in the current directory and subdirectories.
- **Selective processing** – only includes files with common source code / text extensions (configurable).
- **Clear separation** – each file is preceded by `=== File: path ===` and two newlines.
- **Safe for large projects** – uses `find -print0` and `read -d ''` to handle filenames with spaces or special characters.
- **Overwrites output** – the output file (`combined_codes.txt`) is cleared before writing; run repeatedly without accumulating old data.

## Supported File Extensions

By default, the script processes files with these extensions:

```
.java .py .cpp .c .h .hpp .js .html .css .php .rb .go .rs .sh .txt .ts
```

You can easily modify the list inside the script (see [Customization](#customization)).

## Requirements

- **Bash** (any modern version, typically available on Linux, macOS, WSL, or Git Bash for Windows)
- Standard Unix utilities: `find`, `cat`, `echo`

## Installation

1. Download the script:
   ```bash
   curl -O https://raw.githubusercontent.com/Dmitriy-Grebenev/CombineCodes_sh/main/combine_codes.sh
   ```
   or clone the entire repository:
   ```bash
   git clone https://github.com/Dmitriy-Grebenev/CombineCodes_sh.git
   ```

2. Make it executable:
   ```bash
   chmod +x combine_codes.sh
   ```

## Usage

Navigate to the root directory of your project and run:

```bash
./combine_codes.sh
```

After execution, a file named `combined_codes.txt` will be created in the current directory.

### Example

Suppose your project structure looks like this:

```
project/
├── src/
│   ├── main.java
│   └── utils.py
├── README.md
└── data.txt
```

Running `./combine_codes.sh` produces `combined_codes.txt` with content:

```
=== File: ./src/main.java ===
[content of main.java]


=== File: ./src/utils.py ===
[content of utils.py]


=== File: ./data.txt ===
[content of data.txt]
```

> **Note:** `README.md` is ignored because `.md` is not in the default extension list.

## Customization

To add or remove file extensions, edit the `process_file` function inside `combine_codes.sh`. Modify the regex pattern:

```bash
if [[ "$extension" =~ ^(java|py|cpp|c|h|hpp|js|html|css|php|rb|go|rs|sh|txt|ts)$ ]]; then
```

For example, to include `.md` and `.json` files, change it to:

```bash
if [[ "$extension" =~ ^(java|py|cpp|c|h|hpp|js|html|css|php|rb|go|rs|sh|txt|ts|md|json)$ ]]; then
```

## How It Works

1. The script sets `combined_codes.txt` as the output file and empties it.
2. It defines a `process_file` function that:
   - Extracts the file extension.
   - Checks if the extension matches the allowed list.
   - If yes, writes a header line and then appends the entire file content, followed by two newlines.
3. `find . -type f -print0` recursively lists all files (null‑terminated to handle unusual names).
4. The `while` loop reads each file and passes it to `process_file`.

## Limitations

- Binary files (images, PDFs, compiled objects) are **not** filtered by magic bytes – only by extension. If a binary file happens to have one of the allowed extensions (e.g., a malicious `.sh` script that is actually binary), it will be read as text, which may produce garbled output. In practice, this rarely happens in source code repositories.
- Very large projects may generate a multi‑gigabyte output file – be mindful of disk space.

## License

This script is provided under the **MIT License**. Feel free to use, modify, and distribute it.

## Contributing

If you find a bug or have an idea for improvement, please open an issue or submit a pull request.

---

**Enjoy consolidating your codebase!** 

