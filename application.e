note
	description: "A demonstration of across loops and from loops combined."
	EIS: "name=try_IDE", "src=www.eiffel.com"
	EIS: "name=BUY", "src=https://account.eiffel.com/licenses/_/buy/"
	EIS: "name=youtube_video", "src=https://youtu.be/4i1bfw4QtHI"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Examples of across and from loops.
		do
			across some_item_list_to_iterate_over as a_local_iteration_cursor_object loop
				loop_code_goes_here -- A set number of iterations based on `some_item_list_to_iterate_over'
			end

			from setup_code_goes_here until some_condition_is_met loop
				loop_code_goes_here -- arbitrary number of computations ...
			end

			from gradient_descent_setup_code until convergence_is_reached loop
				compute_next_iteration_of_descent -- arbitrary number of computations ...
			end
		end

feature {NONE}

	setup_code_goes_here do  end

	some_condition_is_met: BOOLEAN

	loop_code_goes_here do  end

	some_item_list_to_iterate_over: INTEGER_INTERVAL
		do
			Result := 1 |..| 100
		end

	gradient_descent_setup_code do  end

	convergence_is_reached: BOOLEAN

	compute_next_iteration_of_descent do  end

end
