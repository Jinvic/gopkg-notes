# source .venv/bin/activate
# deactivate

set shell := ["powershell.exe", "-c"]

build:
    zensical build

serve:
    zensical serve
