#!/bin/bash
# Build script for workflow-expert-skills distribution packages
# Creates zip files for all 14 skills across n8n, langflow, and orchestration categories

set -e

DIST_DIR="dist"
VERSION="1.3.0"

echo "🔨 Building workflow-expert-skills distribution packages v${VERSION}..."

# Create dist directory if it doesn't exist
mkdir -p "$DIST_DIR"

# Cleanup
echo "🗑️  Cleaning dist folder..."
rm -f "$DIST_DIR"/*.zip

# Skill categories mapping
CATEGORIES=("n8n" "langflow" "orchestration")

for cat in "${CATEGORIES[@]}"; do
    echo "📦 Processing category: $cat"
    SKILLS_IN_CAT=$(find "skills/$cat" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)
    
    for skill in $SKILLS_IN_CAT; do
        echo "   - $skill"
        # Zip from the skills/ category structure
        (cd "skills/$cat" && zip -rq "../../$DIST_DIR/${skill}-v${VERSION}.zip" "$skill/" -x "*.DS_Store")
    done
done

# Build complete bundle (everything needed to use the repo as a plugin)
echo "📦 Building complete bundle for AI Agents..."
zip -rq "$DIST_DIR/workflow-expert-skills-v${VERSION}.zip" \
    README.md \
    LICENSE \
    skills/ \
    evaluations/ \
    docs/ \
    -x "*.DS_Store"

# Show results
echo ""
echo "✅ Build complete! Files in $DIST_DIR/:"
ls -lh "$DIST_DIR"/*.zip

echo ""
echo "📊 Package count: $(ls "$DIST_DIR"/*.zip | wc -l)"
echo ""
echo "📊 Package sizes:"
du -h "$DIST_DIR"/*.zip
