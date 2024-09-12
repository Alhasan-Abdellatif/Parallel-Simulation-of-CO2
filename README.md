# Parallel Processing of RAW Files with Python

This repository contains a bash script that facilitates the parallel processing of `.raw` files using a Python script. The script dynamically creates job-specific directories, copies necessary files, and runs multiple instances of the Python script in parallel using available CPU cores.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Usage](#usage)
- [Script Parameters](#script-parameters)
- [Example](#example)
- [License](#license)

## Overview
The bash script (`run_jobs.sh`) is designed to process multiple `.raw` files concurrently by distributing the load across available CPU cores. Each `.raw` file is processed in a temporary directory, and the results are stored in a shared destination folder. The Python script that performs the file processing runs within each of these directories, ensuring isolation and preventing file conflicts.

## Requirements
- **Python** (Ensure the Python environment supports running the `run_scripts.py` file.)
- **Bash** (Tested on Linux systems.)
- **OpenFOAM** (for sourcing necessary configurations in the script)
- Ensure the following software and libraries are installed:
  - Python 3.x
  - OpenFOAM
  - GeoChemFoam

## Usage

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

2. **Configure the Script:**
    - Edit the following parameters inside the `run_jobs.sh` script:
      - `input_directory`: Path to the directory containing the `.raw` input files.
      - `original_dir`: Path to the original directory containing the `script.py` file and other necessary resources.
      - `destination_folder`: Path where all output results will be stored.
      - `total_cores`: Total number of cores available on your machine (or use `$(nproc)` to fetch the core count dynamically).
      
3. **Run the Script:**
    Run the bash script to start processing the `.raw` files in parallel:
    ```bash
    ./run_jobs.sh
    ```

## Script Parameters

The bash script accepts no direct input arguments but is configured with the following internal parameters:

- **input_directory**: Directory containing `.raw` files to be processed.
- **original_dir**: Directory containing `run_scripts.py` and required files.
- **destination_folder**: Destination folder where output results will be saved.
- **cores_per_job**: Number of CPU cores allocated per Python job.
- **total_cores**: Total CPU cores available for processing.
- **max_concurrent_jobs**: Maximum number of jobs to run concurrently, calculated by dividing `total_cores` by `cores_per_job`.
- **Python script parameters**: These parameters are passed to `run_scripts.py`:
  - `--raw_file_path`: Path to the input `.raw` file.
  - `--destination_folder`: Path to the folder for saving results.
  - `--num_processors`: Number of processors (default: 16).
  - `--x_dim`, `--y_dim`, `--z_dim`: Dimensions of the image (default: 1000x1000x6).
  - `--cropping`: Whether to apply cropping during processing.

## Example

Assume you have a folder `raw_missed_files_Crop10` containing `.raw` files and a folder `2D_micromodal` with the Python script `run_scripts.py`. The following shows how the script processes each `.raw` file:

```bash
./run_jobs.sh
