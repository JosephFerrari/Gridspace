/// @description Utilities

// Mathematical

function smooth(_value)
{
	return (dsin((_value * 180) - 90) + 1) / 2;
}

// Arrays

function array_from()
{
	var array array_create(argument_count);
	for (var i = 0; i < argument_count; i++)
	{
		array[i] = argument[i];
	}
	return array;
}