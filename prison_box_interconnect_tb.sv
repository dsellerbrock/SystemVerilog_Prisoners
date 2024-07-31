`timescale 1ns/1ns
//`include "prison_box_interconnect.sv"

module prison_box_interconnect_tb;
    // Define the size of the array
    localparam int SIZE = 100;

  function void make_rand_arr(ref int array[SIZE]);
        int i;
		int j;
		int temp;
    
        // Function to initialize the array with numbers 1 through 100
        for (i = 0; i < SIZE; i++) begin
            array[i] = i + 1;
        end

        // Function to shuffle the array using the Fisher-Yates shuffle algorithm
        
        for (i = SIZE - 1; i > 0; i--) begin
            j = $urandom_range(0, i); // Generate a random index between 0 and i
            //Swap array[i] with array[j]
            temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        end
	endfunction

  // Initial block to execute the array initialization and shuffling
  initial begin
    // Initialize the array
	int array1[SIZE];
	make_rand_arr(array1);

    // Display the shuffled array
    $display("Shuffled Array:");
    for (int i = 0; i < SIZE; i++) begin
      $display("%0d", array1[i]);
    end
	$finish;
  end
endmodule