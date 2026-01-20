# Contributing to Master ZSH Configuration

First off, thank you for considering contributing to this project! This project was created for the **OS101 Event by ISTE HIT SC**, and we welcome contributions from everyone.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- A clear and descriptive title
- Detailed steps to reproduce the problem
- Expected behavior vs actual behavior
- Your environment details (OS, ZSH version, etc.)
- Screenshots if applicable

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- A clear and descriptive title
- Detailed description of the proposed feature
- Why this enhancement would be useful
- Examples of how it would work

### Pull Requests

1. Fork the repository
2. Create a new branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes following our coding standards
4. Test your changes thoroughly
5. Commit with clear, descriptive messages
6. Push to your fork
7. Submit a pull request

## Coding Standards

### ZSH Script Guidelines

- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and modular
- Follow existing code style and indentation
- Test on multiple systems if possible

### Function Naming

- Use descriptive names in lowercase
- Separate words with underscores
- Prefix personal/custom functions appropriately

### Comments

- Add section headers using the existing format:
  ```bash
  # ============================================================================
  # SECTION NAME
  # ============================================================================
  ```
- Comment complex operations
- Document function parameters and return values

## Adding New Features

When adding new features:

1. **Aliases**: Add to the ALIASES section with a comment explaining the purpose
   ```bash
   # Description of what this does
   alias myalias='command'
   ```

2. **Functions**: Add to the CUSTOM FUNCTIONS section with documentation
   ```bash
   # Function name and purpose
   # Usage: function_name [arguments]
   function_name() {
       # Implementation
   }
   ```

3. **Plugins**: If suggesting a new plugin:
   - Explain why it's needed
   - Ensure it doesn't conflict with existing plugins
   - Document installation in README

4. **Dependencies**: If adding dependencies:
   - Make them optional when possible
   - Update the installation script
   - Document in README

## Testing

Before submitting:

- Test on a clean ZSH installation
- Verify all functions work as expected
- Check for conflicts with existing configuration
- Test the installation script if modified

## Documentation

- Update README.md for new features
- Add usage examples
- Update installation instructions if needed
- Document any new dependencies

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discriminatory language
- Personal attacks
- Publishing others' private information
- Other unprofessional conduct

## Questions?

Feel free to:
- Open an issue for questions
- Start a discussion for broader topics
- Contact the maintainer

## Attribution

Contributors will be acknowledged in:
- README.md (if significant contribution)
- Git commit history
- Release notes

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to the OS101 event project!**

Made with love by the community for ISTE HIT SC.
