#!/bin/python

import os
import shutil
import argparse
from PIL import Image

def organize_images(input_dir, portrait_dir, landscape_dir):
    # Create directories if they don't exist
    for d in [portrait_dir, landscape_dir]:
        if not os.path.exists(d):
            os.makedirs(d)
            print(f"Created directory: {d}")

    # List of common image extensions
    image_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.gif', '.tiff', '.webp')

    files_processed = 0
    files_moved = 0

    for filename in os.listdir(input_dir):
        file_path = os.path.join(input_dir, filename)

        # Skip directories
        if os.path.isdir(file_path):
            continue

        # Check if file is an image
        if filename.lower().endswith(image_extensions):
            files_processed += 1
            try:
                with Image.open(file_path) as img:
                    width, height = img.size

                if height > width:
                    target_dir = portrait_dir
                    orientation = "portrait"
                else:
                    # Square images are treated as landscape in this script
                    target_dir = landscape_dir
                    orientation = "landscape"

                # Determine target path
                target_path = os.path.join(target_dir, filename)

                # Move file if target directory is different from input directory
                # or if the filename would change (though here we keep it same)
                if os.path.abspath(input_dir) != os.path.abspath(target_dir):
                    shutil.move(file_path, target_path)
                    files_moved += 1
                    print(f"Moved {filename} ({width}x{height}) to {orientation}")
                else:
                    print(f"Skipped {filename} - already in {orientation} directory")

            except Exception as e:
                print(f"Error processing {filename}: {e}")

    print(f"\nProcessed {files_processed} images. Moved {files_moved} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Organize images into portrait and landscape directories.")
    parser.add_argument("input_dir", help="Directory containing the images to organize")
    parser.add_argument("portrait_dir", help="Directory to move portrait images into")
    parser.add_argument("landscape_dir", help="Directory to move landscape images into")

    args = parser.parse_args()

    organize_images(args.input_dir, args.portrait_dir, args.landscape_dir)
