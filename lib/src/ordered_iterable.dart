part of '../enumerable.dart';

abstract class IOrderedIterable<TElement> implements Iterable<TElement> {
  IOrderedIterable<TElement> createOrderedEnumerable<TKey>(
      TKey Function(TElement) keySelector,
      IComparer<TKey> comparer,
      bool descending);

  IOrderedIterable<TElement> thenBy<TKey>(TKey Function(TElement) keySelector,
      [IComparer<TKey> comparer]);

  IOrderedIterable<TElement> thenByDescending<TKey>(
      TKey Function(TElement) keySelector,
      [IComparer<TKey> comparer]);
}

class _OrderedIterable<TElement, TSortKey> extends Iterable<TElement>
    implements IOrderedIterable<TElement> {
  IComparer<TSortKey> _comparer;

  bool _descending;

  TSortKey Function(TElement) _keySelector;

  _OrderedIterable<TElement, Object> _parent;

  Iterable<TElement> _source;

  _OrderedIterable(
      Iterable<TElement> source,
      TSortKey Function(TElement) keySelector,
      IComparer<TSortKey> comparer,
      bool descending,
      this._parent) {
    if (source == null) {
      throw ArgumentError.notNull("source");
    }

    if (keySelector == null) {
      throw ArgumentError.notNull("keySelector");
    }

    if (descending == null) {
      throw ArgumentError.notNull("descending");
    }

    if (comparer == null) {
      comparer = Comparer.getDefault<TSortKey>();
    }

    _comparer = comparer;
    _descending = descending;
    _keySelector = keySelector;
    _source = source;
  }

  Iterator<TElement> get iterator {
    return _orderAll().iterator;
  }

  IOrderedIterable<TElement> createOrderedEnumerable<TKey>(
      TKey Function(TElement) keySelector,
      IComparer<TKey> comparer,
      bool descending) {
    return _OrderedIterable<TElement, TKey>(
        this._source, keySelector, comparer, descending, this);
  }

  IOrderedIterable<TElement> thenBy<TKey>(TKey Function(TElement) keySelector,
      [IComparer<TKey> comparer]) {
    return createOrderedEnumerable<TKey>(keySelector, comparer, false);
  }

  IOrderedIterable<TElement> thenByDescending<TKey>(
      TKey Function(TElement) keySelector,
      [IComparer<TKey> comparer]) {
    return createOrderedEnumerable<TKey>(keySelector, comparer, true);
  }

  List<List<TElement>> _order(List<List<TElement>> data, bool lastLevel) {
    var result = <List<TElement>>[];
    Comparator<TElement> comparator;
    if (_descending) {
      comparator = (TElement x, TElement y) =>
          -_comparer.compare(_keySelector(x), _keySelector(y));
    } else {
      comparator = (TElement x, TElement y) =>
          _comparer.compare(_keySelector(x), _keySelector(y));
    }

    var sorter = _SymmergeSorter<TElement>(comparator);
    var numberOfParts = data.length;
    for (var i = 0; i < numberOfParts; i++) {
      var elements = data[i];
      sorter.sort(elements);
      if (lastLevel) {
        result.add(elements);
        continue;
      }

      var numberOfElements = elements.length;
      if (numberOfElements == 1) {
        result.add([elements[0]]);
        continue;
      }

      var previous = elements[0];
      var newElements = [previous];
      result.add(newElements);
      for (var j = 1; j < numberOfElements; j++) {
        var element = elements[j];
        if (comparator(element, previous) != 0) {
          newElements = <TElement>[];
          result.add(newElements);
        }

        newElements.add(element);
        previous = element;
      }
    }

    return result;
  }

  Iterable<TElement> _orderAll() sync* {
    var source = _source.toList();
    if (source.isEmpty) {
      return;
    }

    var data = <List<TElement>>[];
    data.add(source);
    var queue = <_OrderedIterable<TElement, Object>>[];
    _OrderedIterable<TElement, Object> sequence = this;
    while (sequence != null) {
      queue.add(sequence);
      sequence = sequence._parent;
    }

    for (var i = queue.length - 1; i >= 0; i--) {
      var sequence = queue[i];
      data = sequence._order(data, i == 0);
    }

    var numberOfParts = data.length;
    for (var i = 0; i < numberOfParts; i++) {
      var elements = data[i];
      var numberOfElements = elements.length;
      for (var j = 0; j < numberOfElements; j++) {
        yield elements[j];
      }
    }
  }
}
