# ABZ_Test_Task

Hi. This is a test assignment for ###ABZ agency###.

# Technologies used
	1. SwiftUI
	  - The main framework for building the application interface.
	  - Used declarative approaches to create interface elements such as text boxes, buttons, and lists.
	  - Advantages:
	  - Simplified interface state management.
	  - Easy interface update via data bindings (@State, @ObservedObject).
   
	2. Combine
	  - Used to manage the state of the data via the @ObservedObject object in the SignUpViewModel.
	  - It implements a reactive approach, which simplifies the handling of data changes (e.g., updating the list of items or the state of the signup button).
   
	3. UIKit Integration
	  - Uses UIImagePickerController via the UIViewControllerRepresentable adapter to access the camera.
	  - Benefits of Integration:
	  - Allows you to work with features that are not present in SwiftUI (e.g. camera).
   
# Architectural solutions
	1 Modular approach
	  - The code is divided into separate structural elements:
	  - SignUpView: Main screen with the interface divided into subcomponents.
	  - CameraView: A separate module for working with the camera.
	  - StatusRegistrationView: A separate screen for displaying the result of registration.
	  - CustomTextField: An overused component for data input.
	  - This approach improves code readability, testability and modifiability.
   
	2. Protocol usage
	  - The TextInputProtocol allows you to create generalized components that support different types of data input (e.g. text, phone).
   
	3. Asynchronous data processing
	  - Asynchronous Task and try await functions are used to send data to the server (postUser method).
	  - This reduces the chance of UI blocking, improving the user experience.
   
	4. UI/UX Solutions
	  - Custom text fields with validation and input examples (inputExample).
	  - Interactive position selection with status updates.
	  - Friendly interface for uploading photos (choose from gallery or camera).

# Use of third-party libraries
	- The application does not use any third-party libraries, making it lightweight and fully dependent on standard Swift tools.
