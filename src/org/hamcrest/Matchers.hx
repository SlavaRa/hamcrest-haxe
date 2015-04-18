package org.hamcrest;

import org.hamcrest.collection.IsArray;
import org.hamcrest.collection.IsArrayWithSize;
import org.hamcrest.collection.IsArrayContaining;
import org.hamcrest.collection.IsArrayContainingInOrder;
import org.hamcrest.collection.IsArrayContainingInAnyOrder;
import org.hamcrest.collection.IsEmptyIterable;
import org.hamcrest.collection.IsIterableWithSize;
import org.hamcrest.collection.IsIterableContainingInOrder;
import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.hamcrest.collection.IsHashContaining;

import org.hamcrest.number.IsCloseTo;
import org.hamcrest.number.OrderingComparison;

import org.hamcrest.core.StringEndsWith;
import org.hamcrest.core.StringStartsWith;
import org.hamcrest.core.StringContains;
import org.hamcrest.core.IsSame;
import org.hamcrest.core.IsNull;
import org.hamcrest.core.IsNot;
import org.hamcrest.core.IsInstanceOf;
import org.hamcrest.core.IsEqual;
import org.hamcrest.core.IsCollectionContaining;
import org.hamcrest.core.IsAnything;
import org.hamcrest.core.Is;
import org.hamcrest.core.Every;
import org.hamcrest.core.DescribedAs;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.AnyOf;
import org.hamcrest.core.AllOf;
import haxe.ds.StringMap;

/**
	Provides a shortcut to import all or specific Matchers.
	
	```
	import org.hamcrest.Matchers.*;
	```
**/
class Matchers
{
	private function new() {}

	/**
		Assert that a value is true, or that its Matcher successfully matches the value.
		
		@param actual If no Matcher is defined then must be a boolean, otherwise can be any value.
		@param matcher Matcher used to validate `actual`.
		@param reason Optional description outlining reasoning for match
	**/
	public static function assertThat<T>(actual:Dynamic, ?matcher:Matcher<T>, ?reason:String, ?info:haxe.PosInfos)
	{
		MatcherAssert.assertThat(actual, matcher, reason, info);
	}
	
	// Core Matchers

	/**
		Creates a matcher that matches if the examined object matches *ALL* of the specified matchers.
		
		For example: 
		`assertThat("myValue", allOf(startsWith("my"), containsString("Val")))`.
	**/
	public static function allOf<T>(first:Dynamic,
	                                ?second:Matcher<T>,
	                                ?third:Matcher<T>,
	                                ?fourth:Matcher<T>,
	                                ?fifth:Matcher<T>,
	                                ?sixth:Matcher<T>,
	                                ?seventh:Matcher<T>,
	                                ?eighth:Matcher<T>,
	                                ?ninth:Matcher<T>,
	                                ?tenth:Matcher<T>):AllOf<T>
	{
		return AllOf.allOf(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	/**
		Creates a matcher that matches if the examined object matches *ANY* of the specified matchers.
		
		For example: 
		`assertThat("myValue", anyOf(startsWith("foo"), containsString("Val")))`.
	**/
	public static function anyOf<T>(first:Dynamic,
	                                ?second:Matcher<T>,
	                                ?third:Matcher<T>,
	                                ?fourth:Matcher<T>,
	                                ?fifth:Matcher<T>,
	                                ?sixth:Matcher<T>,
	                                ?seventh:Matcher<T>,
	                                ?eighth:Matcher<T>,
	                                ?ninth:Matcher<T>,
	                                ?tenth:Matcher<T>):AnyOf<T>
	{
		return AnyOf.anyOf(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	/**
		Creates a matcher that matches when both of the specified matchers match the examined object.
		
		For example: 
		`assertThat("fab", both(containsString("a")).and(containsString("b")))`.
	**/
	public static function both<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.both(matcher);
	}

	/**
		Creates a matcher that matches when either of the specified matchers match the examined object.
		
		For example: 
		`assertThat("fan", either(containsString("a")).or(containsString("b")))`.
	**/
	public static function either<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.either(matcher);
	}

	/**
		Wraps an existing matcher, overriding its description with that specified.  
		All other functions are delegated to the decorated matcher, including its 
		mismatch description.

		For example:
		`describedAs("an integer equal to %0", equalTo(myInteger), Std.string(myInteger))`.

		@param description the new description for the wrapped matcher
		@param matcher the matcher to wrap
		@param values optional values to insert into the tokenised description
	**/
	public static function describedAs<T>(description:String, matcher:Matcher<T>, ?values:Array<Dynamic>):Matcher<T>
	{
		return DescribedAs.describedAs(description, matcher, values);
	}

	/**
		Creates a matcher for `Iterable`s that only matches when a single pass over the
		examined `Iterable` yields items that are all matched by the specified `itemMatcher`.

		For example:
		`assertThat(["bar", "baz"], everyItem(startsWith("ba")))`.

		@param itemMatcher the matcher to apply to every item provided by the examined {@link Iterable}
	**/
	public static function everyItem<T>(itemMatcher:Matcher<T>):Matcher<Iterable<T>>
	{
		return Every.everyItem(itemMatcher);
	}

	/**
		A shortcut to the frequently used `is(equalTo(x))`.
		
		For example:
		`assertThat(cheese, is(smelly))`.
		
		If `value` is a `Matcher` then decorates this Matcher, retaining its behaviour, 
		but allowing tests to be slightly more expressive.
		
		For example:
		`assertThat(cheese, is(equalTo(smelly)))`.
		
		instead of:
		`assertThat(cheese, equalTo(smelly))`.
	**/
	public static function is<T>(value:Dynamic):Matcher<T>
	{
		return Is.is(value);
	}

	/**
		A shortcut to the frequently used <code>is(instanceOf(SomeClass.class))</code>.
		
		For example:
		`assertThat(cheese, isA(Cheddar.class))`.

		instead of:
		`assertThat(cheese, is(instanceOf(Cheddar.class)))`.
	**/
	public static function isA<T>(type:Class<Dynamic>):Matcher<T>
	{
		return Is.isA(type);
	}

	/**
		Creates a matcher that always matches, regardless of the examined object.
		
		@param description an optional meaningful description of itself
	**/
	public static function anything(?description:String):Matcher<Dynamic>
	{
		return IsAnything.anything(description);
	}

	/**
		Creates a matcher for `Iterable`s that only matches when a single pass over the
		examined `Iterable` yields at least one item that is matched by the specified
		`value`. If `value` is a matcher then it will be applied against each element,
		otherwise `value` will be compared with each element. 
		
		Whilst matching, the traversal of the examined `Iterable` will stop as soon as 
		a matching item is found.
		
		For example:
		`assertThat(["foo", "bar"], hasItem(startsWith("ba")))`.
		
		Or:
		`assertThat(["foo", "bar"], hasItem("bar"))`.
		 
		@param value the matcher to apply or value to compare to items provided by the examined `Iterable`
	**/
	public static function hasItem<T>(value:Dynamic):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItem(value);
	}

	/**
		Creates a matcher for `Iterable`s that matches when consecutive passes over the
		examined `Iterable` yield at least one item that is, a) matched by the `value` when
		`value` is a Matcher, or b) equal to the a corrosponding item from the array of values.
		
		Whilst matching, each traversal of the examined `Iterable` will stop as soon as
		a matching item is found.

		For example:
		`assertThat(["foo", "bar", "baz"], hasItems([endsWith("z"), endsWith("o")]))`.
		
		Or:
		`assertThat(["foo", "bar", "baz"], hasItems(["baz", "foo"]))`.

		@param itemMatchers the matchers to apply to items provided by the examined {@link Iterable}
	**/
	public static function hasItems<T, U>(values:Array<U>):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItems(values);
	}

	/**
		Creates a matcher that matches when the examined object is logically equal to the specified
		`operand`, as determined by:

		1) If the operand is an enum then `Type.enumEq` is used.
		2) If examined object being compared to `operand` has an `equals` method this is called
			passing the `operand` and expects a boolean outcome. If it doesn't have this method
			but `operand` does then it will be called passing it the examined object.
		3) Direct comparison.

		The created matcher also provides a special behaviour when examining `Array`s, whereby
		it will match if both the operand and the examined object are arrays of the same length
		and contain items that are equal to each other (according to the above rules), in the same
		indexes.

		For example:
		```
		assertThat("foo", equalTo("foo"));
		assertThat(["foo", "bar"], equalTo(["foo", "bar"]));
		```
	**/
	public static function equalTo<T>(operand:Dynamic):Matcher<T>
	{
		return IsEqual.equalTo(operand);
	}

	/**
		Creates a matcher that matches when the examined object is an instance of the 
		specified `type`, as determined by calling the `Std.is`, passing the examined object.

		The created matcher forces a relationship between specified type and the examined object, 
		and should be used when it is necessary to make generics conform.
		
		For example
		`with(any(Thing))`.
	**/
	public static function any<T>(type:Class<Dynamic>):Matcher<T>
	{
		return IsInstanceOf.any(type);
	}

	/**
		Creates a matcher that matches when the examined object is an instance of the 
		specified `type`, as determined by calling the `Std.is`, passing the examined object.

		The created matcher assumes no relationship between specified type and the examined object.

		For example:
		`assertThat(new Canoe(), instanceOf(Paddlable))`.
	**/
	public static function instanceOf<T>(type:Class<Dynamic>):Matcher<T>
	{
		return IsInstanceOf.instanceOf(type);
	}

	/**
		Creates a matcher that wraps an existing matcher or value, but inverts the logic by which 
		it will match.

		For example:
		`assertThat(cheese, is(not(equalTo(smelly))))`.
		
		Or:
		`assertThat(cheese, is(not(smelly)))`.

		@param matcher the matcher whose sense should be inverted
	**/
	public static function not<T>(value:Dynamic):Matcher<T>
	{
		return IsNot.not(value);
	}

	/**
		A shortcut to the frequently used `not(nullValue())`.
		
		For example:
		`assertThat(cheese, is(notNullValue()))`.
		
		instead of:
		`assertThat(cheese, is(not(nullValue())))`.
		
		@param type Optional dummy parameter used to infer the generic type of the returned matcher
	**/
	public static function notNullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.notNullValue(type);
	}

	/**
		Creates a matcher that matches if examined object is `null`.
		
		For example:
		`assertThat(cheese, is(nullValue())`.
		
		@param type Optional dummy parameter used to infer the generic type of the returned matcher
	**/
	public static function nullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.nullValue(type);
	}

	/**
		Creates a matcher that matches only when the examined object is the same instance as
		the specified target object.
		
		For example:
		`assertThat(cheese, is(theInstance(cheese))`.
		
		@param target the target instance against which others should be assessed
	**/
	public static function theInstance<T>(target:T):Matcher<T>
	{
		return IsSame.theInstance(target);
	}

	/**
		Creates a matcher that matches if the examined `String` contains the specified 
		`String` anywhere.

		For example:
		`assertThat("myStringOfNote", containsString("ring"))`.

		@param substring the substring that the returned matcher will expect to find within any examined string
	**/
	public static function containsString(substring:String):Matcher<String>
	{
		return StringContains.containsString(substring);
	}

	/**
		Creates a matcher that matches if the examined `String` starts with the specified `String`.
		
		For example:
		`assertThat("myStringOfNote", startsWith("my"))`.
		
		@param prefix the substring that the returned matcher will expect at the 
					start of any examined string
	**/
	public static function startsWith(prefix:String):Matcher<String>
	{
		return StringStartsWith.startsWith(prefix);
	}

	/**
		Creates a matcher that matches if the examined {@link String} ends with the specified `String`.

		For example:
		`assertThat("myStringOfNote", endsWith("Note"))`.
	
		@param suffix the substring that the returned matcher will expect at the
					end of any examined string
	**/
	public static function endsWith(suffix:String):Matcher<String>
	{
		return StringEndsWith.endsWith(suffix);
	}

	// Comparison

	/**
		Creates a matcher of {@link Comparable} object that matches when the examined object is
		equal to the specified value, as reported by the `compareTo` method of the
		*examined* object.

		For example:
		`assertThat(1, comparesEqualTo(1))`.

		@param value the value which, when passed to the compareTo method of the examined object, should return zero
	**/
	public static function comparesEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.comparesEqualTo(value);
	}

	/**
     * Is value > expected?
     */
	public static function greaterThan(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.greaterThan(value);
	}

	/**
     * Is value >= expected?
     */
	public static function greaterThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.greaterThanOrEqualTo(value);
	}

	/**
     * Is value < expected?
     */
	public static function lessThan(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.lessThan(value);
	}

	/**
     * Is value <= expected?
     */
	public static function lessThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.lessThanOrEqualTo(value);
	}

	public static function closeTo(operand:Float, error:Float):Matcher<Float>
	{
		return new IsCloseTo(operand, error);
	}

	// Collection

	/**
     * Evaluates to true only if each matcher[i] is satisfied by array[i].
     */
	public static function array<T>(first:Dynamic,
	                         ?second:Matcher<T> = null,
	                         ?third:Matcher<T> = null,
	                         ?fourth:Matcher<T> = null,
	                         ?fifth:Matcher<T> = null,
	                         ?sixth:Matcher<T> = null,
	                         ?seventh:Matcher<T> = null,
	                         ?eighth:Matcher<T> = null,
	                         ?ninth:Matcher<T> = null,
	                         ?tenth:Matcher<T> = null):IsArray<T>
	{
		return IsArray.array(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	/**
     * Evaluates to true if any item in an array satisfies the given matcher.
     */
	public static function hasItemInArray<T>(element:Dynamic):Matcher<Array<T>>
	{
		return IsArrayContaining.hasItemInArray(element);
	}

	public static function contains<T>(first:Dynamic,
	                            ?second:Dynamic,
	                            ?third:Dynamic,
	                            ?fourth:Dynamic,
	                            ?fifth:Dynamic,
	                            ?sixth:Dynamic,
	                            ?seventh:Dynamic,
	                            ?eighth:Dynamic,
	                            ?ninth:Dynamic,
	                            ?tenth:Dynamic):Matcher<Iterable<T>>
	{
		return IsIterableContainingInOrder.contains(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function containsInAnyOrder<T>(first:Dynamic,
	                                      ?second:Dynamic,
	                                      ?third:Dynamic,
	                                      ?fourth:Dynamic,
	                                      ?fifth:Dynamic,
	                                      ?sixth:Dynamic,
	                                      ?seventh:Dynamic,
	                                      ?eighth:Dynamic,
	                                      ?ninth:Dynamic,
	                                      ?tenth:Dynamic):Matcher<Iterable<T>>
	{
		return IsIterableContainingInAnyOrder.containsInAnyOrder(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function arrayContainingInAnyOrder<T>(first:Dynamic,
	                                             ?second:Dynamic,
	                                             ?third:Dynamic,
	                                             ?fourth:Dynamic,
	                                             ?fifth:Dynamic,
	                                             ?sixth:Dynamic,
	                                             ?seventh:Dynamic,
	                                             ?eighth:Dynamic,
	                                             ?ninth:Dynamic,
	                                             ?tenth:Dynamic):Matcher<Array<T>>
	{
		return IsArrayContainingInAnyOrder.arrayContainingInAnyOrder(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function arrayContaining<T>(first:Dynamic, 
	                                          ?second:Dynamic, 
	                                          ?third:Dynamic, 
	                                          ?fourth:Dynamic, 
	                                          ?fifth:Dynamic,
	                                          ?sixth:Dynamic, 
	                                          ?seventh:Dynamic, 
	                                          ?eighth:Dynamic, 
	                                          ?ninth:Dynamic, 
	                                          ?tenth:Dynamic):Matcher<Array<T>>
	{
		return IsArrayContainingInOrder.arrayContaining(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function arrayWithSize<T>(value:Dynamic):Matcher<Array<T>>
	{
		return IsArrayWithSize.arrayWithSize(value);
	}

	public static function emptyArray<E>():Matcher<Array<E>>
	{
		return IsArrayWithSize.emptyArray();
	}

	public static function emptyIterable<E>():Matcher<Iterable<E>>
	{
		return IsEmptyIterable.emptyIterable();
	}

	public static function iterableWithSize<E>(value:Dynamic):Matcher<Iterable<E>>
	{
		return IsIterableWithSize.iterableWithSize(value);
	}

	public static function hasEntry<V>(key:Dynamic, value:Dynamic):Matcher<StringMap<V>>
	{
		return IsHashContaining.hasEntry(key, value);
	}

	public static function hasKey(key:Dynamic):Matcher<StringMap<Dynamic>>
	{
		return IsHashContaining.hasKey(key);
	}

	public static function hasValue<V>(value:Dynamic):Matcher<StringMap<V>>
	{
		return IsHashContaining.hasValue(value);
	}
}
