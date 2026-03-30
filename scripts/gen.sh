#!/bin/bash
set -e

echo "Generating l10n..."
flutter gen-l10n

echo "Running build_runner..."
dart run build_runner build --delete-conflicting-outputs

echo "Done!"
