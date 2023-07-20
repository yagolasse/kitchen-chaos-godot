extends Node
class_name AnimationCurves

static func ease_out_quad(x: float) -> float:
	return 1 - (1 - x) * (1 - x)


static func ease_in_out_cubic(x: float) -> float:
	return 4 * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 3) / 2;
