# Hotel-Booking-BA-Assessment-Project
This project is structured as a human-readable Business Analyst assessment rather than one large code dump.

This project is structured as a human-readable Business Analyst assessment rather
than one large code dump.

## Main file

`hotel_booking_BA_assessment.ipynb`

The notebook is deliberately broken into small sections with:
- business-question headings
- data-quality checks
- visible print statements
- intermediate tables
- arithmetic calculations
- visualizations
- final business answers
- interview explanation

## Required input

Place the supplied dataset here:

`hotel_bookings.csv`

## Outputs

The notebook creates:
- cleaned_hotel_bookings.csv
- CS1_cancellation_landscape.png
- CS2_top3_by_rate.csv
- CS2_top3_by_count.csv
- CS3_root_cause_comparison.png
- weather outputs when the API is available

## Submission recommendation

Submit the notebook together with the SQL files and README. Do not submit
fabricated screenshots or hard-coded outputs. Run the notebook top-to-bottom
with the original dataset immediately before submission.
"""

(project_dir / "code" / "01_data_quality_and_cleaning.py").write_text(clean_script, encoding="utf-8")
(project_dir / "code" / "02_cancellation_case_study.py").write_text(analysis_script, encoding="utf-8")
(project_dir / "code" / "03_arithmetic_audit.py").write_text(arithmetic_script, encoding="utf-8")
(project_dir / "sql" / "schema.sql").write_text(schema_sql, encoding="utf-8")
(project_dir / "sql" / "A-Q1.sql").write_text(q1_sql, encoding="utf-8")
(project_dir / "sql" / "A-Q2.sql").write_text(q2_sql, encoding="utf-8")
(project_dir / "project" / "README.md").write_text(project_readme, encoding="utf-8")
(project_dir / "README.md").write_text(main_readme, encoding="utf-8")

notebook = {
    "cells": cells,
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "name": "python",
            "version": "3.x"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 5
}

nb_path = project_dir / "hotel_booking_BA_assessment.ipynb"
nb_path.write_text(json.dumps(notebook, indent=2, ensure_ascii=False), encoding="utf-8")

zip_path = Path("/mnt/data/hotel_booking_BA_assessment_project.zip")
if zip_path.exists():
    zip_path.unlink()

with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
    for path in project_dir.rglob("*"):
        if path.is_file():
            z.write(path, path.relative_to(project_dir.parent))

print(f"Created notebook: {nb_path}")
print(f"Created project ZIP: {zip_path}")
print("The notebook is intentionally not executed because the source CSV is not present in the current runtime.")
