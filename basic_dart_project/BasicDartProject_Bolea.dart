import 'dart:io'; // Import the Dart IO library for input/output

// --- User-Defined Functions ---

// Function to display the operation menu
void displayMenu(List<String> operations) {
  print("\n----- Calculator Menu -----");
  print("Available operations:");
  // Use a 'for' loop to iterate through the list of operations
  for (String op in operations) {
    stdout.write("$op  "); // Print operations on the same line
  }
  print("\nEnter 'exit' to quit.");
  print("-------------------------");
}

// Function to get a valid number input from the user1
double getNumberInput(String prompt) {
  double? number; // Use nullable double for validation
  // Use a 'while' loop to keep asking until valid input is received
  while (number == null) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input != null) {
      number = double.tryParse(input); // Try converting input to double
      if (number == null) {
        print("Invalid input. Please enter a number.");
      }
    } else {
      print("No input received. Please try again.");
    }
  }
  return number; // Return the valid number
}

// Function to perform the calculation
// Returns double? (nullable) to handle potential errors like division by zero
double? performCalculation(double num1, double num2, String operation) {
  double? result; // Variable to store the result

  // Use a 'switch' statement for control flow based on the operation
  switch (operation) {
    case '+':
      result = num1 + num2;
      break; // Exit the switch
    case '-':
      result = num1 - num2;
      break;
    case '*':
      result = num1 * num2;
      break;
    case '/':
      // Use an 'if' statement for control flow (check for division by zero)
      if (num2 == 0) {
        print("Error: Cannot divide by zero.");
        result = null; // Indicate an error by returning null
      } else {
        result = num1 / num2;
      }
      break;
    default:
      print("Error: Invalid operation '$operation'.");
      result = null; // Indicate an error
  }
  return result;
}

// --- Main Program Execution ---
void main() {
  // Use a List to store the valid operations
  List<String> validOperations = ['+', '-', '*', '/'];
  bool keepCalculating = true; // Variable to control the main loop

  print("Welcome to the Dart Calculator!");

  // Main application loop ('while' loop)
  while (keepCalculating) {
    // Call function to display menu
    displayMenu(validOperations);

    // Get operation choice
    stdout.write("Choose an operation: ");
    String? operationInput =
        stdin.readLineSync()?.trim(); // Read and trim whitespace

    // Check if user wants to exit
    if (operationInput?.toLowerCase() == 'exit') {
      keepCalculating = false; // Set flag to false to stop the while loop
      print("Exiting calculator. Goodbye!");
      continue; // Skip the rest of the loop iteration
    }

    // Validate operation choice
    if (operationInput == null || !validOperations.contains(operationInput)) {
      if (!validOperations.contains(operationInput ?? '')) {
        // Also check if it's in our list
        print(
          "Invalid operation selected. Please choose from: ${validOperations.join(', ')}",
        );
        continue; // Go back to the start of the loop
      }
    }

    // Get number inputs using the function
    // Variables to store numbers
    double number1 = getNumberInput("Enter the first number: ");
    double number2 = getNumberInput("Enter the second number: ");

    // Perform calculation using the function
    // Variable to store calculation result
    double? result = performCalculation(
      number1,
      number2,
      operationInput!,
    ); // Use ! because we checked for null/invalid

    // Output the result
    if (result != null) {
      print("-------------------------");
      print("Result: $number1 $operationInput $number2 = $result");
      print("-------------------------");
    }
    // If result is null, an error message was already printed by performCalculation
  }
}
