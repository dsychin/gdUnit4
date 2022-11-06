extends GdUnitTestSuite

func test_equals_string():
	var a := ""
	var b := ""
	var c := "abc"
	var d := "abC"
	
	assert_bool(GdObjects.equals("", "")).is_true()
	assert_bool(GdObjects.equals(a, "")).is_true()
	assert_bool(GdObjects.equals("", a)).is_true()
	assert_bool(GdObjects.equals(a, a)).is_true()
	assert_bool(GdObjects.equals(a, b)).is_true()
	assert_bool(GdObjects.equals(b, a)).is_true()
	assert_bool(GdObjects.equals(c, c)).is_true()
	assert_bool(GdObjects.equals(c, String(c))).is_true()
	
	assert_bool(GdObjects.equals(a, null)).is_false()
	assert_bool(GdObjects.equals(null, a)).is_false()
	assert_bool(GdObjects.equals("", c)).is_false()
	assert_bool(GdObjects.equals(c, "")).is_false()
	assert_bool(GdObjects.equals(c, d)).is_false()
	assert_bool(GdObjects.equals(d, c)).is_false()
	# against diverent type
	assert_bool(GdObjects.equals(d, Array())).is_false()
	assert_bool(GdObjects.equals(d, Dictionary())).is_false()
	assert_bool(GdObjects.equals(d, Vector2.ONE)).is_false()
	assert_bool(GdObjects.equals(d, Vector3.ONE)).is_false()

func test_equals_array():
	var a := []
	var b := []
	var c := Array()
	var d := [1,2,3,4,5]
	var e := [1,2,3,4,5]
	var x := [1,2,3,6,4,5]
	
	assert_bool(GdObjects.equals(a, a)).is_true()
	assert_bool(GdObjects.equals(a, b)).is_true()
	assert_bool(GdObjects.equals(b, a)).is_true()
	assert_bool(GdObjects.equals(a, c)).is_true()
	assert_bool(GdObjects.equals(c, b)).is_true()
	assert_bool(GdObjects.equals(d, d)).is_true()
	assert_bool(GdObjects.equals(d, e)).is_true()
	assert_bool(GdObjects.equals(e, d)).is_true()
	
	assert_bool(GdObjects.equals(a, null)).is_false()
	assert_bool(GdObjects.equals(null, a)).is_false()
	assert_bool(GdObjects.equals(a, d)).is_false()
	assert_bool(GdObjects.equals(d, a)).is_false()
	assert_bool(GdObjects.equals(d, x)).is_false()
	assert_bool(GdObjects.equals(x, d)).is_false()
	# against diverent type
	assert_bool(GdObjects.equals(a, "")).is_false()
	assert_bool(GdObjects.equals(a, Dictionary())).is_false()
	assert_bool(GdObjects.equals(a, Vector2.ONE)).is_false()
	assert_bool(GdObjects.equals(a, Vector3.ONE)).is_false()

func test_equals_dictionary():
	var a := {}
	var b := {}
	var c := {"a":"foo"}
	var d := {"a":"foo"}
	var e1 := {"a":"foo", "b":"bar"}
	var e2 := {"b":"bar", "a":"foo"}
	
	assert_bool(GdObjects.equals(a, a)).is_true()
	assert_bool(GdObjects.equals(a, b)).is_true()
	assert_bool(GdObjects.equals(b, a)).is_true()
	assert_bool(GdObjects.equals(c, c)).is_true()
	assert_bool(GdObjects.equals(c, d)).is_true()
	assert_bool(GdObjects.equals(e1, e2)).is_true()
	assert_bool(GdObjects.equals(e2, e1)).is_true()
	
	assert_bool(GdObjects.equals(a, null)).is_false()
	assert_bool(GdObjects.equals(null, a)).is_false()
	assert_bool(GdObjects.equals(a, c)).is_false()
	assert_bool(GdObjects.equals(c, a)).is_false()
	assert_bool(GdObjects.equals(a, e1)).is_false()
	assert_bool(GdObjects.equals(e1, a)).is_false()
	assert_bool(GdObjects.equals(c, e1)).is_false()
	assert_bool(GdObjects.equals(e1, c)).is_false()

class TestClass extends Resource:
	
	enum {
		A,
		B
	}
	
	var _type := A
	var _a:int
	var _b:String
	var _c:Array
	
	func _init(a:int = 0,b:String = "",c:Array = []):
		_a = a
		_b = b
		_c = c

func test_equals_class():
	var a := TestClass.new()
	var b := TestClass.new()
	var c := TestClass.new(1, "foo", ["bar", "xxx"])
	var d := TestClass.new(1, "foo", ["bar", "xxx"])
	var x := TestClass.new(1, "foo", ["bar", "xsxx"])
	
	assert_bool(GdObjects.equals(a, a)).is_true()
	assert_bool(GdObjects.equals(a, b)).is_true()
	assert_bool(GdObjects.equals(b, a)).is_true()
	assert_bool(GdObjects.equals(c, d)).is_true()
	assert_bool(GdObjects.equals(d, c)).is_true()
	
	assert_bool(GdObjects.equals(a, null)).is_false()
	assert_bool(GdObjects.equals(null, a)).is_false()
	assert_bool(GdObjects.equals(a, c)).is_false()
	assert_bool(GdObjects.equals(c, a)).is_false()
	assert_bool(GdObjects.equals(d, x)).is_false()
	assert_bool(GdObjects.equals(x, d)).is_false()

func test_equals_with_stack_deep():
	# more extended version
	var x2 := TestClass.new(1, "foo", [TestClass.new(22, "foo"), TestClass.new(22, "foo")])
	var x3 := TestClass.new(1, "foo", [TestClass.new(22, "foo"), TestClass.new(23, "foo")])
	assert_bool(GdObjects.equals(x2, x3)).is_false()

func test_equals_Node_with_deep_check():
	var nodeA = auto_free(Node.new())
	var nodeB = auto_free(Node.new())
	
	# compares by default with deep ckeck checked
	assert_bool(GdObjects.equals(nodeA, nodeA)).is_true()
	assert_bool(GdObjects.equals(nodeB, nodeB)).is_true()
	assert_bool(GdObjects.equals(nodeA, nodeB)).is_true()
	assert_bool(GdObjects.equals(nodeB, nodeA)).is_true()
	# compares by default with deep ckeck unchecked
	assert_bool(GdObjects.equals(nodeA, nodeA, false, false)).is_true()
	assert_bool(GdObjects.equals(nodeB, nodeB, false, false)).is_true()
	assert_bool(GdObjects.equals(nodeA, nodeB, false, false)).is_false()
	assert_bool(GdObjects.equals(nodeB, nodeA, false, false)).is_false()

func test_is_primitive_type():
	assert_bool(GdObjects.is_primitive_type(false)).is_true()
	assert_bool(GdObjects.is_primitive_type(true)).is_true()
	assert_bool(GdObjects.is_primitive_type(0)).is_true()
	assert_bool(GdObjects.is_primitive_type(0.1)).is_true()
	assert_bool(GdObjects.is_primitive_type("")).is_true()
	assert_bool(GdObjects.is_primitive_type(Vector2.ONE)).is_false()

func test_is_array_type():
	assert_bool(GdObjects.is_array_type([])).is_true()
	assert_bool(GdObjects.is_array_type(Array())).is_true()
	assert_bool(GdObjects.is_array_type(PackedByteArray())).is_true()
	assert_bool(GdObjects.is_array_type(PackedColorArray())).is_true()
	assert_bool(GdObjects.is_array_type(PackedInt32Array())).is_true()
	assert_bool(GdObjects.is_array_type(PackedFloat32Array())).is_true()
	assert_bool(GdObjects.is_array_type(PackedStringArray())).is_true()
	assert_bool(GdObjects.is_array_type(PackedVector2Array())).is_true()
	assert_bool(GdObjects.is_array_type(PackedVector3Array())).is_true()
	assert_bool(GdObjects.is_array_type(false)).is_false()

class TestClassForIsType:
	var x

func test_is_type():
	# check build-in types
	assert_bool(GdObjects.is_type(1)).is_false()
	assert_bool(GdObjects.is_type(1.3)).is_false()
	assert_bool(GdObjects.is_type(true)).is_false()
	assert_bool(GdObjects.is_type(false)).is_false()
	assert_bool(GdObjects.is_type([])).is_false()
	assert_bool(GdObjects.is_type("abc")).is_false()
	
	assert_bool(GdObjects.is_type(null)).is_false()
	# an object type
	assert_bool(GdObjects.is_type(Node)).is_true()
	# an reference type
	assert_bool(GdObjects.is_type(AStar3D)).is_true()
	# an script type
	assert_bool(GdObjects.is_type(GDScript)).is_true()
	# an custom type
	assert_bool(GdObjects.is_type(TestClassForIsType)).is_true()
	# checked inner class type
	assert_bool(GdObjects.is_type(CustomClass.InnerClassA)).is_true()
	assert_bool(GdObjects.is_type(CustomClass.InnerClassC)).is_true()
	
	# for instances must allways endup with false
	assert_bool(GdObjects.is_type(auto_free(Node.new()))).is_false()
	assert_bool(GdObjects.is_type(AStar3D.new())).is_false()
	assert_bool(GdObjects.is_type(Dictionary())).is_false()
	assert_bool(GdObjects.is_type(PackedColorArray())).is_false()
	assert_bool(GdObjects.is_type(GDScript.new())).is_false()
	assert_bool(GdObjects.is_type(TestClassForIsType.new())).is_false()
	assert_bool(GdObjects.is_type(auto_free(CustomClass.InnerClassC.new()))).is_false()

func _is_instance(value) -> bool:
	return GdObjects.is_instance(auto_free(value))

func test_is_instance_true():
	assert_bool(_is_instance(Node.new())).is_true()
	assert_bool(_is_instance(AStar3D.new())).is_true()
	assert_bool(_is_instance(PackedScene.new())).is_true()
	assert_bool(_is_instance(GDScript.new())).is_true()
	assert_bool(_is_instance(Person.new())).is_true()
	assert_bool(_is_instance(CustomClass.new())).is_true()
	assert_bool(_is_instance(CustomNodeTestClass.new())).is_true()
	assert_bool(_is_instance(TestClassForIsType.new())).is_true()
	assert_bool(_is_instance(CustomClass.InnerClassC.new())).is_true()

func test_is_instance_false():
	assert_bool(_is_instance(Node)).is_false()
	assert_bool(_is_instance(AStar3D)).is_false()
	assert_bool(_is_instance(PackedScene)).is_false()
	assert_bool(_is_instance(GDScript)).is_false()
	assert_bool(_is_instance(Dictionary())).is_false()
	assert_bool(_is_instance(PackedColorArray())).is_false()
	assert_bool(_is_instance(Person)).is_false()
	assert_bool(_is_instance(CustomClass)).is_false()
	assert_bool(_is_instance(CustomNodeTestClass)).is_false()
	assert_bool(_is_instance(TestClassForIsType)).is_false()
	assert_bool(_is_instance(CustomClass.InnerClassC)).is_false()

func test_is_instanceof():
	var obj = auto_free(Camera3D.new())
	assert_bool(GdObjects.is_instanceof(obj, Node)).is_true()
	assert_bool(GdObjects.is_instanceof(obj, AStar2D)).is_false()

# shorter helper func to extract class name and using auto_free
func extract_class_name(value) -> Result:
	return GdObjects.extract_class_name(auto_free(value))

func test_get_class_name_from_class_path():
	# extract class name by resoure path
	assert_result(extract_class_name("res://addons/gdUnit4/test/resources/core/Person.gd"))\
		.is_success().is_value("Person")
	assert_result(extract_class_name("res://addons/gdUnit4/test/resources/core/CustomClass.gd"))\
		.is_success().is_value("CustomClass")
	assert_result(extract_class_name("res://addons/gdUnit4/test/mocker/resources/CustomNodeTestClass.gd"))\
		.is_success().is_value("CustomNodeTestClass")
	assert_result(extract_class_name("res://addons/gdUnit4/test/mocker/resources/CustomResourceTestClass.gd"))\
		.is_success().is_value("CustomResourceTestClass")
	assert_result(extract_class_name("res://addons/gdUnit4/test/mocker/resources/OverridenGetClassTestClass.gd"))\
		.is_success().is_value("OverridenGetClassTestClass")

func test_get_class_name_from_snake_case_class_path():
	assert_result(extract_class_name("res://addons/gdUnit4/test/core/resources/naming_conventions/snake_case_with_class_name.gd"))\
		.is_success().is_value("SnakeCaseWithClassName")
	# without class_name
	assert_result(extract_class_name("res://addons/gdUnit4/test/core/resources/naming_conventions/snake_case_without_class_name.gd"))\
		.is_success().is_value("SnakeCaseWithoutClassName")

func test_get_class_name_from_pascal_case_class_path():
	assert_result(extract_class_name("res://addons/gdUnit4/test/core/resources/naming_conventions/PascalCaseWithClassName.gd"))\
		.is_success().is_value("PascalCaseWithClassName")
	# without class_name
	assert_result(extract_class_name("res://addons/gdUnit4/test/core/resources/naming_conventions/PascalCaseWithoutClassName.gd"))\
		.is_success().is_value("PascalCaseWithoutClassName")

func test_get_class_name_from_type():
	assert_result(extract_class_name(Animation)).is_success().is_value("Animation")
	assert_result(extract_class_name(GDScript)).is_success().is_value("GDScript")
	assert_result(extract_class_name(Camera3D)).is_success().is_value("Camera3D")
	assert_result(extract_class_name(Node)).is_success().is_value("Node")
	assert_result(extract_class_name(Tree)).is_success().is_value("Tree")
	# extract class name from custom classes
	assert_result(extract_class_name(Person)).is_success().is_value("Person")
	assert_result(extract_class_name(CustomClass)).is_success().is_value("CustomClass")
	assert_result(extract_class_name(CustomNodeTestClass)).is_success().is_value("CustomNodeTestClass")
	assert_result(extract_class_name(CustomResourceTestClass)).is_success().is_value("CustomResourceTestClass")
	assert_result(extract_class_name(OverridenGetClassTestClass)).is_success().is_value("OverridenGetClassTestClass")
	assert_result(extract_class_name(AdvancedTestClass)).is_success().is_value("AdvancedTestClass")

func test_get_class_name_from_inner_class():
	assert_result(extract_class_name(CustomClass))\
		.is_success().is_value("CustomClass")
	assert_result(extract_class_name(CustomClass.InnerClassA))\
		.is_success().is_value("CustomClass.InnerClassA")
	assert_result(extract_class_name(CustomClass.InnerClassB))\
		.is_success().is_value("CustomClass.InnerClassB")
	assert_result(extract_class_name(CustomClass.InnerClassC))\
		.is_success().is_value("CustomClass.InnerClassC")
	assert_result(extract_class_name(CustomClass.InnerClassD))\
		.is_success().is_value("CustomClass.InnerClassD")
	assert_result(extract_class_name(AdvancedTestClass.SoundData))\
		.is_success().is_value("AdvancedTestClass.SoundData")
	assert_result(extract_class_name(AdvancedTestClass.AtmosphereData))\
		.is_success().is_value("AdvancedTestClass.AtmosphereData")
	assert_result(extract_class_name(AdvancedTestClass.Area4D))\
		.is_success().is_value("AdvancedTestClass.Area4D")

func test_extract_class_name_from_instance():
	assert_result(extract_class_name(Camera3D.new())).is_equal("Camera3D")
	assert_result(extract_class_name(GDScript.new())).is_equal("GDScript")
	assert_result(extract_class_name(Node.new())).is_equal("Node")
	
	# extract class name from custom classes
	assert_result(extract_class_name(Person.new())).is_equal("Person")
	assert_result(extract_class_name(ClassWithNameA.new())).is_equal("ClassWithNameA")
	assert_result(extract_class_name(ClassWithNameB.new())).is_equal("ClassWithNameB")
	var classWithoutNameA = load("res://addons/gdUnit4/test/mocker/resources/ClassWithoutNameA.gd")
	assert_result(extract_class_name(classWithoutNameA.new())).is_equal("ClassWithoutNameA")
	assert_result(extract_class_name(CustomNodeTestClass.new())).is_equal("CustomNodeTestClass")
	assert_result(extract_class_name(CustomResourceTestClass.new())).is_equal("CustomResourceTestClass")
	assert_result(extract_class_name(OverridenGetClassTestClass.new())).is_equal("OverridenGetClassTestClass")
	assert_result(extract_class_name(AdvancedTestClass.new())).is_equal("AdvancedTestClass")
	# extract inner class name
	assert_result(extract_class_name(AdvancedTestClass.SoundData.new())).is_equal("AdvancedTestClass.SoundData")
	assert_result(extract_class_name(AdvancedTestClass.AtmosphereData.new())).is_equal("AdvancedTestClass.AtmosphereData")
	# assert_result(extract_class_name(AdvancedTestClass.Area4D.new())).is_equal("AdvancedTestClass.Area4D")
	assert_result(extract_class_name(CustomClass.InnerClassC.new())).is_equal("CustomClass.InnerClassC")

# verify enigne class names are not converted by configured naming convention
func test_extract_class_name_from_class_path(fuzzer=GodotClassNameFuzzer.new(true, true), fuzzer_iterations = 100) -> void:
	var clazz_name :String = fuzzer.next_value()
	assert_str(GdObjects.extract_class_name_from_class_path(PackedStringArray([clazz_name]))).is_equal(clazz_name)

func test_extract_class_name_godot_classes(fuzzer=GodotClassNameFuzzer.new(true, true)):
	var extract_class_name := fuzzer.next_value() as String
	var instance :Variant = ClassDB.instantiate(extract_class_name)
	assert_result(extract_class_name(instance)).is_equal(extract_class_name)

func test_extract_class_path_by_clazz():
	# engine classes has no class path
	assert_array(GdObjects.extract_class_path(Animation)).is_empty()
	assert_array(GdObjects.extract_class_path(GDScript)).is_empty()
	assert_array(GdObjects.extract_class_path(Camera3D)).is_empty()
	assert_array(GdObjects.extract_class_path(Tree)).is_empty()
	assert_array(GdObjects.extract_class_path(Node)).is_empty()
	
	# script classes
	assert_array(GdObjects.extract_class_path(Person))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/Person.gd"])
	assert_array(GdObjects.extract_class_path(CustomClass))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/CustomClass.gd"])
	assert_array(GdObjects.extract_class_path(CustomNodeTestClass))\
		.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/CustomNodeTestClass.gd"])
	assert_array(GdObjects.extract_class_path(CustomResourceTestClass))\
		.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/CustomResourceTestClass.gd"])
	assert_array(GdObjects.extract_class_path(OverridenGetClassTestClass))\
		.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/OverridenGetClassTestClass.gd"])
	
	# script inner classes
	assert_array(GdObjects.extract_class_path(CustomClass.InnerClassA))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/CustomClass.gd", "InnerClassA"])
	assert_array(GdObjects.extract_class_path(CustomClass.InnerClassB))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/CustomClass.gd", "InnerClassB"])
	assert_array(GdObjects.extract_class_path(CustomClass.InnerClassC))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/CustomClass.gd", "InnerClassC"])
	assert_array(GdObjects.extract_class_path(AdvancedTestClass.SoundData))\
		.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/AdvancedTestClass.gd", "SoundData"])
	assert_array(GdObjects.extract_class_path(AdvancedTestClass.AtmosphereData))\
		.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/AdvancedTestClass.gd", "AtmosphereData"])
	assert_array(GdObjects.extract_class_path(AdvancedTestClass.Area4D))\
	.contains_exactly(["res://addons/gdUnit4/test/mocker/resources/AdvancedTestClass.gd", "Area4D"])
	
	# inner inner class
	assert_array(GdObjects.extract_class_path(CustomClass.InnerClassD.InnerInnerClassA))\
		.contains_exactly(["res://addons/gdUnit4/test/resources/core/CustomClass.gd", "InnerClassD", "InnerInnerClassA"])

func test_is_same():
	assert_bool(GdObjects.is_same(1, 1)).is_true()
	assert_bool(GdObjects.is_same(1, 2)).is_false()
	assert_bool(GdObjects.is_same(1.0, 1.0)).is_true()
	assert_bool(GdObjects.is_same(1, 1.0)).is_false()
	
	var obj1 = auto_free(Camera3D.new())
	var obj2 = auto_free(Camera3D.new())
	var obj3 = auto_free(obj2.duplicate())
	assert_bool(GdObjects.is_same(obj1, obj1)).is_true()
	assert_bool(GdObjects.is_same(obj1, obj2)).is_false()
	assert_bool(GdObjects.is_same(obj1, obj3)).is_false()
	assert_bool(GdObjects.is_same(obj2, obj1)).is_false()
	assert_bool(GdObjects.is_same(obj2, obj2)).is_true()
	assert_bool(GdObjects.is_same(obj2, obj3)).is_false()
	assert_bool(GdObjects.is_same(obj3, obj1)).is_false()
	assert_bool(GdObjects.is_same(obj3, obj2)).is_false()
	assert_bool(GdObjects.is_same(obj3, obj3)).is_true()

#func __test_can_instantiate():
#	assert_bool(GdObjects.can_instantiate(GDScript)).is_true()
#	assert_bool(GdObjects.can_instantiate(Node)).is_true()
#	assert_bool(GdObjects.can_instantiate(Tree)).is_true()
#	assert_bool(GdObjects.can_instantiate(Camera3D)).is_true()
#	assert_bool(GdObjects.can_instantiate(Person)).is_true()
#	assert_bool(GdObjects.can_instantiate(CustomClass.InnerClassA)).is_true()
#	assert_bool(GdObjects.can_instantiate(TreeItem)).is_true()
#
# creates a test instance by given class name or resource path
# instances created with auto free
func create_instance(clazz):
	var result := GdObjects.create_instance(clazz)
	if result.is_success():
		return auto_free(result.value())
	return null

func test_create_instance_by_class_name():
	# instance of engine classes
	assert_object(create_instance(Node))\
		.is_not_null()\
		.is_instanceof(Node)
	assert_object(create_instance(Camera3D))\
		.is_not_null()\
		.is_instanceof(Camera3D)
	# instance of custom classes
	assert_object(create_instance(Person))\
		.is_not_null()\
		.is_instanceof(Person)
	# instance of inner classes
	assert_object(create_instance(CustomClass.InnerClassA))\
		.is_not_null()\
		.is_instanceof(CustomClass.InnerClassA)

func test_extract_class_name_on_null_value():
	# we can't extract class name from a null value
	assert_result(GdObjects.extract_class_name(null))\
		.is_error()\
		.contains_message("Can't extract class name form a null value.")

func test_is_public_script_class() -> void:
	# snake case format class names
	assert_bool(GdObjects.is_public_script_class("ScriptWithClassName")).is_true()
	assert_bool(GdObjects.is_public_script_class("script_without_class_name")).is_false()
	assert_bool(GdObjects.is_public_script_class("CustomClass")).is_true()
	# inner classes not listed as public classes
	assert_bool(GdObjects.is_public_script_class("CustomClass.InnerClassA")).is_false()

func test_array_filter_value() -> void:
	assert_array(GdObjects.array_filter_value([], null)).is_empty()
	assert_array(GdObjects.array_filter_value([], "")).is_empty()
	
	var current :Array = [null, "a", "b", null, "c", null]
	var filtered := GdObjects.array_filter_value(current, null)
	assert_array(filtered).contains_exactly(["a", "b", "c"])
	# verify the source is not affected
	assert_array(current).contains_exactly([null, "a", "b", null, "c", null])
	
	current = [null, "a", "xxx", null, "xx", null]
	filtered = GdObjects.array_filter_value(current, "xxx")
	assert_array(filtered).contains_exactly([null, "a", null, "xx", null])
	# verify the source is not affected
	assert_array(current).contains_exactly([null, "a", "xxx", null, "xx", null])

func test_array_erase_value() -> void:
	var current := []
	GdObjects.array_erase_value(current, null)
	assert_array(current).is_empty()
	
	current = [null]
	GdObjects.array_erase_value(current, null)
	assert_array(current).is_empty()
	
	current = [null, "a", "b", null, "c", null]
	GdObjects.array_erase_value(current, null)
	# verify the source is affected
	assert_array(current).contains_exactly(["a", "b", "c"])

func test_is_instance_scene() -> void:
	# checked none scene objects
	assert_bool(GdObjects.is_instance_scene(RefCounted.new())).is_false()
	assert_bool(GdObjects.is_instance_scene(CustomClass.new())).is_false()
	assert_bool(GdObjects.is_instance_scene(auto_free(Control.new()))).is_false()
	
	# now check checked a loaded scene
	var resource = load("res://addons/gdUnit4/test/mocker/resources/scenes/TestScene.tscn")
	assert_bool(GdObjects.is_instance_scene(resource)).is_false()
	# checked a instance of a scene
	assert_bool(GdObjects.is_instance_scene(auto_free(resource.instantiate()))).is_true()

func test_is_scene_resource_path() -> void:
	assert_bool(GdObjects.is_scene_resource_path(RefCounted.new())).is_false()
	assert_bool(GdObjects.is_scene_resource_path(CustomClass.new())).is_false()
	assert_bool(GdObjects.is_scene_resource_path(auto_free(Control.new()))).is_false()
	
	# check checked a loaded scene
	var resource = load("res://addons/gdUnit4/test/mocker/resources/scenes/TestScene.tscn")
	assert_bool(GdObjects.is_scene_resource_path(resource)).is_false()
	# checked resource path
	assert_bool(GdObjects.is_scene_resource_path("res://addons/gdUnit4/test/mocker/resources/scenes/TestScene.tscn")).is_true()

func test_extract_class_functions() -> void:
	var functions := GdObjects.extract_class_functions("Resource", [""])
	for f in functions:
		if f["name"] == "get_path":
			assert_str(GdFunctionDescriptor.extract_from(f)._to_string()).is_equal("[Line:-1] func get_path() -> String:")
	
	functions = GdObjects.extract_class_functions("CustomResourceTestClass", ["res://addons/gdUnit4/test/mocker/resources/CustomResourceTestClass.gd"])
	for f in functions:
		if f["name"] == "get_path":
			assert_str(GdFunctionDescriptor.extract_from(f)._to_string()).is_equal("[Line:-1] func get_path() -> String:")

func test_all_types() -> void:
	
	var expected_types :Array[int] = [] 
	for type_index in TYPE_MAX:
		expected_types.append(type_index)
	expected_types.append(GdObjects.TYPE_VOID)
	expected_types.append(GdObjects.TYPE_VARARG)
	expected_types.append(GdObjects.TYPE_FUNC)
	expected_types.append(GdObjects.TYPE_FUZZER)
	expected_types.append(GdObjects.TYPE_VARIANT)
	assert_array(GdObjects.all_types()).contains_exactly_in_any_order(expected_types)

func test_to_camel_case() -> void:
	assert_str(GdObjects.to_camel_case("MyClassName")).is_equal("myClassName")
	assert_str(GdObjects.to_camel_case("my_class_name")).is_equal("myClassName")
	assert_str(GdObjects.to_camel_case("myClassName")).is_equal("myClassName")

func test_to_pascal_case() -> void:
	assert_str(GdObjects.to_pascal_case("MyClassName")).is_equal("MyClassName")
	assert_str(GdObjects.to_pascal_case("my_class_name")).is_equal("MyClassName")
	assert_str(GdObjects.to_pascal_case("myClassName")).is_equal("MyClassName")

func test_to_snake_case() -> void:
	assert_str(GdObjects.to_snake_case("MyClassName")).is_equal("my_class_name")
	assert_str(GdObjects.to_snake_case("my_class_name")).is_equal("my_class_name")
	assert_str(GdObjects.to_snake_case("myClassName")).is_equal("my_class_name")

func test_is_snake_case() -> void:
	assert_bool(GdObjects.is_snake_case("my_class_name")).is_true()
	assert_bool(GdObjects.is_snake_case("myclassname")).is_true()
	assert_bool(GdObjects.is_snake_case("MyClassName")).is_false()
	assert_bool(GdObjects.is_snake_case("my_class_nameTest")).is_false()