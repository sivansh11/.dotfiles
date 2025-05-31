import os

def generate_wofi_css_with_wal_colors(wal_colors_file_path="~/.cache/wal/colors"):
    """
    Generates a Wofi style.css file using colors from a pywal colors file.

    Args:
        wal_colors_file_path (str): The path to the pywal colors file.
                                     Defaults to "~/.cache/wal/colors".
    """
    expanded_path = os.path.expanduser(wal_colors_file_path)
    colors = []

    try:
        with open(expanded_path, 'r') as f:
            for line in f:
                colors.append(line.strip())
    except FileNotFoundError:
        print(f"Error: Wal colors file not found at {expanded_path}")
        print("Please ensure pywal has been run and the colors file exists.")
        return

    if len(colors) < 16:
        print(f"Warning: Expected at least 16 colors in {expanded_path}, but found {len(colors)}. Using fallback colors.")
        # Fallback colors if not enough colors are found
        # These are just example fallbacks and can be adjusted
        fallback_colors = [
            "#000000", "#FF0000", "#00FF00", "#FFFF00", "#0000FF", "#FF00FF", "#00FFFF", "#FFFFFF",
            "#808080", "#C0C0C0", "#FFC0CB", "#FFA07A", "#20B2AA", "#9370DB", "#7CFC00", "#ADD8E6"
        ]
        colors.extend(fallback_colors[len(colors):])


    # Assign wal colors to specific variables for readability and easy mapping
    background_color = colors[0]  # Typically the darkest color
    foreground_color = colors[7]  # Typically the lightest color
    accent_color_1 = colors[4]    # A common accent color (e.g., blue)
    accent_color_2 = colors[5]    # Another accent color (e.g., magenta)
    dim_background = colors[8]    # A slightly lighter background variant

    css_content = f"""
* {{
	font-family: "Hack", monospace;
}}
window {{
margin: 0px;
border: 1px solid {accent_color_1}; /* Using an accent color for the border */
border-radius: 11px;
background-color: {background_color};
}}

#input {{
margin: 5px;
border: none;
border-radius: 11px;
color: {foreground_color};
background-color: {background_color};
}}

#inner-box {{
margin: 5px;
border: none;
border-radius: 11px;
background-color: {dim_background}; /* Slightly different background for inner box */
}}

#outer-box {{
margin: 5px;
border: none;
border-radius: 11px;
background-color: {dim_background}; /* Slightly different background for outer box */
}}

#scroll {{
margin: 0px;
border: none;
border-radius: 11px;
}}

#text {{
margin: 5px;
border: none;
border-radius: 11px;
color: {foreground_color};
}}

#entry:selected {{
border-radius: 11px;
background: {accent_color_2}; /* Using an accent color for selected entry background */
}}
"""
    output_file_path = "/home/sivansh/.config/wofi/style.css"
    with open(output_file_path, 'w') as f:
        f.write(css_content)
    print(f"Generated Wofi style.css with wal colors at {output_file_path}")

# Run the function to generate the CSS
if __name__ == "__main__":
    generate_wofi_css_with_wal_colors()
