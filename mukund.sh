#!/bin/bash

# Starting point (adjust this date as needed)
START_DATE="2025-03-25"

# Define the pattern for "MUKUND" with 5 columns per letter and 1 column gap.
# Offsets: M=0, U=6, K=12, U=18, N=24, D=30

MUKUND_PATTERN=(
  # Letter M (offset 0)
  "1 0" "1 4" \
  "2 0" "2 1" "2 3" "2 4" \
  "3 0" "3 2" "3 4" \
  "4 0" "4 4" \
  "5 0" "5 4" \
  
  # Letter U (offset 6)
  "1 $((0+6))" "1 $((4+6))" \
  "2 $((0+6))" "2 $((4+6))" \
  "3 $((0+6))" "3 $((4+6))" \
  "4 $((0+6))" "4 $((4+6))" \
  "5 $((0+6))" "5 $((1+6))" "5 $((2+6))" "5 $((3+6))" "5 $((4+6))" \
  
  # Letter K (offset 12)
  "1 $((0+12))" "1 $((4+12))" \
  "2 $((0+12))" "2 $((3+12))" \
  "3 $((0+12))" "3 $((2+12))" \
  "4 $((0+12))" "4 $((3+12))" \
  "5 $((0+12))" "5 $((4+12))" \
  
  # Letter U (offset 18)
  "1 $((0+18))" "1 $((4+18))" \
  "2 $((0+18))" "2 $((4+18))" \
  "3 $((0+18))" "3 $((4+18))" \
  "4 $((0+18))" "4 $((4+18))" \
  "5 $((0+18))" "5 $((1+18))" "5 $((2+18))" "5 $((3+18))" "5 $((4+18))" \
  
  # Letter N (offset 24)
  "1 $((0+24))" "1 $((4+24))" \
  "2 $((0+24))" "2 $((1+24))" "2 $((4+24))" \
  "3 $((0+24))" "3 $((2+24))" "3 $((4+24))" \
  "4 $((0+24))" "4 $((3+24))" "4 $((4+24))" \
  "5 $((0+24))" "5 $((4+24))" \
  
  # Letter D (offset 30)
  "1 $((0+30))" "1 $((1+30))" "1 $((2+30))" "1 $((3+30))" \
  "2 $((0+30))" "2 $((4+30))" \
  "3 $((0+30))" "3 $((4+30))" \
  "4 $((0+30))" "4 $((4+30))" \
  "5 $((0+30))" "5 $((1+30))" "5 $((2+30))" "5 $((3+30))"
)

# For each coordinate in the pattern, make 5 commits on the calculated day.
for PIXEL in "${MUKUND_PATTERN[@]}"; do
    read ROW COL <<< "$PIXEL"
    # Calculate the commit date:
    # Each commit's date is determined by (col * 7 + row) days added to START_DATE.
    COMMIT_DATE=$(date -d "$START_DATE +$((COL * 7 + ROW)) days" +"%Y-%m-%d 12:00:00")
    
    # Loop 5 times to create 5 commits on that same day.
    for i in {1..5}; do
        GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" \
          git commit --allow-empty -m "Pixel at row $ROW, col $COL - commit $i"
    done
done

# Push all the commits to GitHub
git push origin main
