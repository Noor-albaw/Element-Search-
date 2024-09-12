**element Search - Digital System Design
Project Overview
This project involves designing a High-Level State Machine (HLSM) for a digital system that processes an array of ten 7-bit unsigned numbers and finds the location of the first element before which all elements are smaller and after which all elements are greater. If no such element exists, the system returns a specific flag.

Features
Input: Array of ten 7-bit unsigned numbers (A[6:0][0:9])
Output: A 4-bit location (0-9) indicating the index of the first qualifying element, or 15 if no such element is found.
Control Signals:
Reset: Initializes the system.
Start: Begins the search.
Ack: Acknowledges the search completion and returns the system to the initial state.
Example Use Case:
Input: {14, 9, 23, 18, 43, 49, 45, 60, 100, 90}
Output: 4 (Element at index 4 satisfies the search criteria)
System Design
States
Initial State:
Upon reset, the system stores the input array A into an internal array Ain.
Search Process:
When the Start signal is activated, the system traverses the array to find the first element where all preceding elements are smaller, and all following elements are greater.
Completion:
The system enters the DONE state once the search is completed and remains in this state until the Ack signal is received, then resets to the initial state.
Versions Implemented
Moore Machine (Moore_Search_ID1_ID2_ID3.v): The system is implemented as a Moore machine, where the output depends only on the state.
Mealy Machine (Mealy_Search_ID1_ID2_ID3.v): The system is implemented as a Mealy machine, where the output depends on both the state and the input.
Testbench
Testbench File (Search_tb.v): This testbench file instantiates both the Moore and Mealy machine implementations. It tests the system with different input scenarios, calculates the total number of clock cycles (excluding INITIAL and DONE states), and prints the output location.
