import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// 왼쪽으로 슬라이드하면 수정(파랑)/삭제(빨강) 액션이 고정 노출되는 공용 래퍼.
/// 지출 카드, 카테고리 타일 등에서 재사용한다.
class EditDeleteSlidable extends StatelessWidget {
  const EditDeleteSlidable({
    required Key key,
    required this.onEdit,
    required this.onDelete,
    required this.child,
  }) : super(key: key);

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.42,
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '수정',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '삭제',
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
          ),
        ],
      ),
      child: child,
    );
  }
}
