import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App bar variant types for different screen contexts
enum AppBarVariant {
  /// Standard app bar with title and optional actions
  standard,

  /// Search-focused app bar with search field
  search,

  /// Contextual app bar for selection mode
  contextual,

  /// Transparent app bar for overlay contexts
  transparent,
}

/// A custom app bar widget implementing Contemporary Productive Minimalism
/// with clean, purposeful design optimized for mobile productivity workflows.
///
/// Features:
/// - Multiple variants (standard, search, contextual, transparent)
/// - Smooth 200-300ms transitions
/// - Touch-optimized 48dp action buttons
/// - Optional search functionality
/// - Contextual actions for selection mode
/// - Platform-adaptive styling
///
/// Usage:
/// ```dart
/// CustomAppBar(
///   title: 'Dashboard',
///   variant: AppBarVariant.standard,
///   actions: [
///     IconButton(icon: Icon(Icons.search), onPressed: () {}),
///   ],
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a custom app bar
  ///
  /// [title] - The title text or widget (required for standard/contextual variants)
  /// [variant] - The app bar variant type (default: standard)
  /// [leading] - Optional leading widget (back button, menu, etc.)
  /// [actions] - Optional list of action widgets
  /// [onSearchChanged] - Callback for search input (required for search variant)
  /// [searchHint] - Hint text for search field (default: 'Search...')
  /// [selectedCount] - Number of selected items (for contextual variant)
  /// [onClearSelection] - Callback to clear selection (for contextual variant)
  /// [backgroundColor] - Optional background color override
  /// [elevation] - Elevation of the app bar (default: 0)
  /// [centerTitle] - Whether to center the title (default: false)
  const CustomAppBar({
    super.key,
    this.title,
    this.variant = AppBarVariant.standard,
    this.leading,
    this.actions,
    this.onSearchChanged,
    this.searchHint = 'Search...',
    this.selectedCount,
    this.onClearSelection,
    this.backgroundColor,
    this.elevation = 0,
    this.centerTitle = false,
  }) : assert(
         variant != AppBarVariant.search || onSearchChanged != null,
         'onSearchChanged is required for search variant',
       ),
       assert(
         variant != AppBarVariant.contextual || selectedCount != null,
         'selectedCount is required for contextual variant',
       );

  /// The title text or widget
  final dynamic title;

  /// The app bar variant type
  final AppBarVariant variant;

  /// Optional leading widget
  final Widget? leading;

  /// Optional list of action widgets
  final List<Widget>? actions;

  /// Callback for search input changes
  final ValueChanged<String>? onSearchChanged;

  /// Hint text for search field
  final String searchHint;

  /// Number of selected items (contextual variant)
  final int? selectedCount;

  /// Callback to clear selection (contextual variant)
  final VoidCallback? onClearSelection;

  /// Optional background color override
  final Color? backgroundColor;

  /// Elevation of the app bar
  final double elevation;

  /// Whether to center the title
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case AppBarVariant.search:
        return _buildSearchAppBar(context, theme, colorScheme);
      case AppBarVariant.contextual:
        return _buildContextualAppBar(context, theme, colorScheme);
      case AppBarVariant.transparent:
        return _buildTransparentAppBar(context, theme, colorScheme);
      case AppBarVariant.standard:
      default:
        return _buildStandardAppBar(context, theme, colorScheme);
    }
  }

  /// Build standard app bar
  Widget _buildStandardAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      leading: leading,
      title: _buildTitle(theme),
      centerTitle: centerTitle,
      actions: _buildActions(context),
      backgroundColor: backgroundColor ?? colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: elevation,
      scrolledUnderElevation: 2.0,
      surfaceTintColor: colorScheme.surfaceTint,
    );
  }

  /// Build search app bar with search field
  Widget _buildSearchAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      leading:
          leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).maybePop(),
            tooltip: 'Back',
          ),
      title: TextField(
        autofocus: true,
        onChanged: onSearchChanged,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: searchHint,
          hintStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => onSearchChanged?.call(''),
          tooltip: 'Clear',
        ),
        if (actions != null) ...actions!,
      ],
      backgroundColor: backgroundColor ?? colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: elevation,
    );
  }

  /// Build contextual app bar for selection mode
  Widget _buildContextualAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onClearSelection,
        tooltip: 'Clear selection',
      ),
      title: Text(
        '$selectedCount selected',
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
      actions: _buildActions(context),
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: elevation,
    );
  }

  /// Build transparent app bar for overlay contexts
  Widget _buildTransparentAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return AppBar(
      leading: leading,
      title: _buildTitle(theme),
      centerTitle: centerTitle,
      actions: _buildActions(context),
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
    );
  }

  /// Build title widget
  Widget? _buildTitle(ThemeData theme) {
    if (title == null) return null;

    if (title is String) {
      return Text(
        title as String,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
      );
    }

    return title as Widget;
  }

  /// Build action widgets with proper spacing
  List<Widget>? _buildActions(BuildContext context) {
    if (actions == null || actions!.isEmpty) return null;

    return [
      ...actions!,
      const SizedBox(width: 8), // Right padding
    ];
  }
}

/// Extension for common app bar actions
extension CustomAppBarActions on CustomAppBar {
  /// Create a search action button
  static Widget searchAction({
    required VoidCallback onPressed,
    String tooltip = 'Search',
  }) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }

  /// Create a filter action button
  static Widget filterAction({
    required VoidCallback onPressed,
    String tooltip = 'Filter',
    bool hasActiveFilters = false,
  }) {
    return IconButton(
      icon: Badge(
        isLabelVisible: hasActiveFilters,
        child: const Icon(Icons.filter_list),
      ),
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }

  /// Create a more options action button
  static Widget moreAction({
    required VoidCallback onPressed,
    String tooltip = 'More options',
  }) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }

  /// Create a sync action button
  static Widget syncAction({
    required VoidCallback onPressed,
    String tooltip = 'Sync',
    bool isSyncing = false,
  }) {
    return IconButton(
      icon: isSyncing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.sync),
      onPressed: isSyncing ? null : onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }

  /// Create a delete action button (for contextual mode)
  static Widget deleteAction({
    required VoidCallback onPressed,
    String tooltip = 'Delete',
  }) {
    return IconButton(
      icon: const Icon(Icons.delete_outline),
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }

  /// Create a share action button
  static Widget shareAction({
    required VoidCallback onPressed,
    String tooltip = 'Share',
  }) {
    return IconButton(
      icon: const Icon(Icons.share_outlined),
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: 24,
    );
  }
}
