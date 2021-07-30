extends UnitTest

var stack: Stack

func before_each():
	stack = autofree(Stack.new())
	watch_signals(stack)


func test_stack():
	stack.push("Item 1")
	assert_eq(stack.current, "Item 1")
	assert_signal_emit_count(stack, "changed", 1)
	
	stack.push("Item 2")
	assert_eq(stack.current, "Item 2")
	assert_signal_emit_count(stack, "changed", 2)
	
	stack.pop()
	assert_eq(stack.current, "Item 1")
	assert_signal_emit_count(stack, "changed", 3)
	
	stack.pop()
	assert_eq(stack.current, "Item 1")
	assert_signal_emit_count(stack, "changed", 3)
	
