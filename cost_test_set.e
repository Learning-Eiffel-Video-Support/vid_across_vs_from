note
	description: "[
		Working demonstration of a combined or integrated 
		across-loop and from-loop by way of Gradient Descent.
	]"
	testing: "type/manual"

							-- Hover link, click open.
	EIS: "name=TRY_IDE", "src=www.eiffel.com"
	EIS: "name=BUY", "src=https://account.eiffel.com/licenses/_/buy/"

	EIS: "name=YouTube_Video", "src=https://youtu.be/4i1bfw4QtHI"
	EIS: "name=YouTube_Video_this_class", "src=https://youtu.be/4i1bfw4QtHI?t=107"

	EIS: "name=java_example_as_basis", "src=https://www.baeldung.com/java-gradient-descent"

class
	COST_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	test_cost_convergence
			-- Test Gradient Descent and cost convergence
			--	on a local and global minima.
		note
			testing:  "covers/{COST_TEST_SET}.descent_convergence_at_x",
						"covers/{COST_TEST_SET}.precision",
						"covers/{COST_TEST_SET}.step_coefficient",
						"covers/{COST_TEST_SET}.f",
						"execution/isolated", "execution/serial"
		local
			x, y: REAL_64
		do
				-- Test just the f-of-x function.
			y := f(-2.25)
			assert_strings_equal ("rough_global_minima", "-6.046875", y.out)
			y := f(1.50)
			assert_strings_equal ("rough_local_minima", "-1.875", y.out)


				-- Prepare by setting `precision' and `step_coefficient' values.
			precision := 0.000001
			step_coefficient := 0.1

				-- Test the Local Minima for F(x)
			x := descent_convergence_at_x (1, 100)
			assert_integers_equal ("local_iterations", 60, last_iteration_count)
			assert_strings_equal ("local_minima_x", "1.8164978634483617", x.out)
			assert_strings_equal ("local_minima_y", "-2.0886621078930445", last_y.out)

				-- Test the Global Minima for F(x)
			x := descent_convergence_at_x (-1, 100)
			assert_integers_equal ("global_iterations", 55, last_iteration_count)
			assert_strings_equal ("global_minima_x", "-2.1546997874679086", x.out)
			assert_strings_equal ("global_minima_y", "-6.0792014356718695", last_y.out)
		end

feature {NONE} -- Implementation

	precision: REAL_64
			-- How precise must covergence be?

	step_coefficient: REAL_64
			-- What is the initial step value?

	f (x: REAL_64): REAL_64
			-- A function to operate Gradient Descent on.
		do
			Result := (x^3).abs - (3 * x^2) + x
		end

	last_iteration_count: INTEGER
			-- When running `descent_convergence_at_x', what was
			--	the	`last_iteration_count'?

	last_y: REAL_64
			-- When running `descent_convergence_at_x', what was
			--	the	`last_y' value computed?

	descent_convergence_at_x (a_initial_x: REAL_64; a_max_iterations: INTEGER): REAL_64
			-- Compute Gradient Descent until approaching convergence.
		note
			EIS: "name=java_example_as_basis",
					"src=https://www.baeldung.com/java-gradient-descent"
		require
			has_precision: precision /= 0.0
			has_step: step_coefficient /= 0.0
		local
			l_step_coefficient, l_previous_step,
			x, l_previous_x,
			y, l_previous_y: REAL_64
			i: INTEGER
		do
			across
				1 |..| a_max_iterations as ic
			from
				i := 0
				l_step_coefficient := step_coefficient
				l_previous_x := a_initial_x
				l_previous_y := f(l_previous_x)
				x := l_previous_x + (l_step_coefficient * l_previous_y)
				l_previous_step := (x - l_previous_x).abs		-- size of step
			until
				l_previous_step < precision
			loop
				y := f(x)
				if y > l_previous_y then
					l_step_coefficient := -(l_step_coefficient / 2)
				end
				l_previous_x := x
				x := x + (l_step_coefficient * l_previous_y)
    			l_previous_step := (x - l_previous_x).abs		-- size of step
    			l_previous_y := y
    			i := i + 1
			end
			Result := x
			last_iteration_count := i
			last_y := y
		end

end


