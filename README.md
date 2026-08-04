# Windows Developer CLI Tools (`dev-.bat-scripts-win-cli`)

A lightweight collection of Windows `.bat` scripts designed to automate daily Python, FastAPI, Docker, and AI engineering workflows directly from your Command Prompt or Git Bash terminal.

---

## Included Scripts & Commands

| Shortcut Command | Script File | Description |
| :--- | :--- | :--- |
| **`uvi`** | `uvi.bat` | Launches FastAPI application via Uvicorn with hot-reloading (`--reload`) |
| **`act`** | `act.bat` | Auto-detects and activates local virtual environment (`.venv`, `venv`, or `env`) |
| **`pyclean`** | `pyclean.bat` | Recursively removes `__pycache__`, `.pytest_cache`, `.mypy_cache`, and `.pyc` files |
| **`clipcode <file>`** | `clipcode.bat` | Copies the entire contents of a specified code file directly to your Windows clipboard |
| **`qdrant`** | `qdrant.bat` | Starts a local Qdrant Vector Database instance using Docker |
| **`ol <model>`** | `ol.bat` | Quick launcher for local Ollama LLM models (defaults to `llama3.2`) |
| **`killport <port>`** | `killport.bat` | Force-terminates process hanging on a specified port (default `8000`) |

---

## How to Add `C:\Tools` to Windows PATH

To run these commands from **any** folder in your terminal, `C:\Tools` must be added to your system's Environment Variables.

### Method 1: Graphical Interface (GUI)

1. Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
2. Type `sysdm.cpl` and press **Enter**.
3. Go to the **Advanced** tab and click **Environment Variables...**.
4. Under **User variables** (or **System variables**), select `Path` and click **Edit...**.
5. Click **New** on the right side.
6. Type or paste: `C:\Tools`
7. Click **OK** on all open windows to save changes.

### Method 2: Command Prompt (Admin)

Open **Command Prompt as Administrator** and run:

```cmd
setx PATH "%PATH%;C:\Tools" /M