from pathlib import Path

# ==============================================================================
# 1. PASTE YOUR DIRECTORY PATH HERE
# ==============================================================================
TARGET_PATH = r"F:\vector-db\AI-Knowledge-Base\backend\app"

# Folders to automatically ignore
IGNORE_DIRS = {
    "__pycache__",
    ".git",
    ".venv",
    "venv",
    "node_modules",
    ".idea",
    ".vscode",
    ".pytest_cache",
    ".mypy_cache",
}


def print_directory_tree(
    root_dir: str | Path, ignore_dirs: set[str] = IGNORE_DIRS
) -> None:
    """Prints directory structure down to files (like `tree /F`)

    while skipping specified noise folders.
    """
    root_path = Path(root_dir).resolve()

    if not root_path.exists():
        print(f"❌ Error: Path '{root_dir}' does not exist.")
        return
    if not root_path.is_dir():
        print(f"❌ Error: Path '{root_dir}' is not a directory.")
        return

    print(f"Folder PATH listing for volume\n{root_path}\n")

    def _tree(directory: Path, prefix: str = "") -> None:
        try:
            # Collect and filter items
            children = [
                path
                for path in directory.iterdir()
                if path.name not in ignore_dirs
            ]
        except PermissionError:
            return  # Skip restricted folders

        # Sort: Folders first, then files alphabetically
        children.sort(key=lambda p: (not p.is_dir(), p.name.lower()))

        count = len(children)
        for index, path in enumerate(children):
            is_last = index == count - 1

            # Visual tree branches
            connector = "└── " if is_last else "├── "
            print(f"{prefix}{connector}{path.name}")

            if path.is_dir():
                extension = "    " if is_last else "│   "
                _tree(path, prefix + extension)

    _tree(root_path)


if __name__ == "__main__":
    print_directory_tree(TARGET_PATH)