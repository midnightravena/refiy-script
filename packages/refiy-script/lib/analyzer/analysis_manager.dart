import '../ast/ast.dart';
import '../resource/resource_manager.dart';
import '../resource/resource_context.dart';
import '../source/source.dart';
import '../error/error_handler.dart';
import 'analysis_result.dart';
import 'analyzer.dart';
import '../bundler/bundler.dart';
import '../parser/parser_hetu.dart';

class RSAnalysisManager {
  final RSErrorHandlerCallback? errorHandler;
  
  final RSSourceManager<RSSource, RSResourceContext<RSSource>>
      sourceContextManager;

  final _pathsToAnalyzer = <String, RSAnalyzer>{};

  final _cachedSourceAnalysisResults = <String, RSSourceAnalysisResult>{};

  Iterable<String> get pathsToAnalyze => _pathsToAnalyzer.keys;

  RSAnalysisManager(this.sourceContextManager, {this.errorHandler}) {
    sourceContextManager.onRootsUpdated = () {
      for (final context in sourceContextManager.contexts) {
        final analyzer = RSAnalyzer(sourceContext: context);
        for (final path in context.included) {
          _pathsToAnalyzer[path] = analyzer;
        }
      }
    };
  }

  ASTSource? getParseResult(String fullName) {
    return _cachedSourceAnalysisResults[fullName]!.parseResult;
  }

  RSSourceAnalysisResult analyze(String fullName) {
    final analyzer = _pathsToAnalyzer[fullName]!;
    final source = sourceContextManager.getResource(fullName)!;
    final bundler = RSBundler(sourceContext: analyzer.sourceContext);
    final parser = RSParserRefiy();
    final compilation = bundler.bundle(source: source, parser: parser);
    final result = analyzer.analyzeCompilation(compilation);
    _cachedSourceAnalysisResults.addAll(result.sourceAnalysisResults);
    return result.sourceAnalysisResults.values.last;
  }
}
