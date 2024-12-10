import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit_dialog.dart';

class MePage extends StatefulWidget {
  final String token;

  const MePage({super.key, required this.token});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  bool updateDailyNutrients = true; // Checkbox state
  Map<String, dynamic>? userData; // User data
  bool isLoading = true; // Loading indicator state
  String errorMessage = ''; // Error message for display
  final Map<String, dynamic> updatedFields = {}; // Changes to be submitted

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final url = Uri.parse('http://localhost:5022/api/auth/me');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          errorMessage = errorData['message'] ?? 'Failed to fetch user details';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $error';
      });
      debugPrint('Error fetching user details: $error');
    }
  }

  Future<void> _updateUserDetails() async {
    final url = Uri.parse('http://localhost:5022/api/auth/details');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode(updatedFields),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data['user']; // Update local state with new data
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(errorData['message'] ?? 'Failed to update user details'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      debugPrint('Error updating user details: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Me'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData != null
              ? ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    buildEditableField(
                        context, 'Goal', userData!['goal'] ?? 'Not set'),
                    buildEditableField(context, 'Age',
                        '${userData!['age'] ?? 'Not set'} years'),
                    buildEditableField(context, 'Height',
                        '${userData!['height'] ?? 'Not set'} cm'),
                    buildEditableField(context, 'Weight',
                        '${userData!['weight'] ?? 'Not set'} kg'),
                    buildEditableField(
                        context, 'Gender', userData!['gender'] ?? 'Not set'),
                    buildEditableField(context, 'Lifestyle',
                        userData!['activity'] ?? 'Not set'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _updateUserDetails,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Center(
                      child: Text(
                        "You can EDIT the values by CLICKING on them",
                        style:
                            TextStyle(color: Colors.green[800], fontSize: 16),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    errorMessage.isNotEmpty
                        ? errorMessage
                        : 'Failed to load user data',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
    );
  }

  Widget buildEditableField(BuildContext context, String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(title),
      trailing: GestureDetector(
        onTap: () async {
          final updatedValue = await showEditDialog(context, title, value);
          if (updatedValue != null) {
            setState(() {
              updatedFields[title.toLowerCase()] = updatedValue;
              userData![title.toLowerCase()] = updatedValue;
            });
          }
        },
        child: Text(
          value,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'edit_dialog.dart';

// class MePage extends StatefulWidget {
//   final String token;

//   const MePage({super.key, required this.token});

//   @override
//   State<MePage> createState() => _MePageState();
// }

// class _MePageState extends State<MePage> {
//   bool updateDailyNutrients = true; // Checkbox state
//   Map<String, dynamic>? userData; // User data
//   bool isLoading = true; // Loading indicator state
//   String errorMessage = ''; // Error message for display

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//   }

//   Future<void> _fetchUserDetails() async {
//     final url = Uri.parse('http://localhost:5022/api/auth/me');
//     try {
//       final response = await http.get(
//         url,
//         headers: {'Authorization': 'Bearer ${widget.token}'},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           userData = jsonDecode(response.body);
//           isLoading = false;
//         });
//       } else {
//         final errorData = jsonDecode(response.body);
//         setState(() {
//           isLoading = false;
//           errorMessage = errorData['message'] ?? 'Failed to fetch user details';
//         });
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error: $error';
//       });
//       debugPrint('Error fetching user details: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Me'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : userData != null
//               ? ListView(
//                   padding: const EdgeInsets.all(16.0),
//                   children: [
//                     buildEditableField(
//                         context, 'Goal', userData!['goal'] ?? 'Not set'),
//                     buildEditableField(context, 'Age',
//                         '${userData!['age'] ?? 'Not set'} years'),
//                     buildEditableField(context, 'Height',
//                         '${userData!['height'] ?? 'Not set'} cm'),
//                     buildEditableField(context, 'Weight',
//                         '${userData!['weight'] ?? 'Not set'} kg'),
//                     buildEditableField(
//                         context, 'Gender', userData!['gender'] ?? 'Not set'),
//                     buildEditableField(context, 'Lifestyle',
//                         userData!['activity'] ?? 'Not set'),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         showSaveDialog(context);
//                       },
//                       child: const Text(
//                         'Save',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         "You can EDIT the values by CLICKING on them",
//                         style:
//                             TextStyle(color: Colors.green[800], fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 )
//               : Center(
//                   child: Text(
//                     errorMessage.isNotEmpty
//                         ? errorMessage
//                         : 'Failed to load user data',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//     );
//   }

//   Widget buildEditableField(BuildContext context, String title, String value) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//       title: Text(title),
//       trailing: GestureDetector(
//         onTap: () {
//           showEditDialog(context, title, value);
//         },
//         child: Text(
//           value,
//           style: const TextStyle(color: Colors.blue),
//         ),
//       ),
//     );
//   }

//   void showSaveDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Save'),
//           content: Row(
//             children: [
//               Checkbox(
//                 value: updateDailyNutrients,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     updateDailyNutrients = value ?? true;
//                   });
//                   Navigator.of(context).pop(); // Close the dialog temporarily
//                   showSaveDialog(
//                       context); // Reopen the dialog with updated state
//                 },
//               ),
//               const Expanded(
//                 child: Text('Update daily nutrients'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle the save action
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'edit_dialog.dart';

// class MePage extends StatefulWidget {
//   const MePage({super.key, required String token});

//   @override
//   State<MePage> createState() => _MePageState();
// }

// class _MePageState extends State<MePage> {
//   bool updateDailyNutrients = true; // Checkbox state

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('Me'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           buildEditableField(context, 'Goal', 'Gain weight'),
//           buildEditableField(context, 'Age', '17 years'),
//           buildEditableField(context, 'Height', '184 cm'),
//           buildEditableField(context, 'Weight', '88 kg'),
//           buildEditableField(context, 'Gender', 'Male'),
//           buildEditableField(context, 'Lifestyle', 'Active'),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed: () {
//               showSaveDialog(context);
//             },
//             child: const Text(
//               'Save',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//           Center(
//               child: Text("You can EDIT the values by CLICKING on them",
//                   style: TextStyle(color: Colors.green[800], fontSize: 16))),
//         ],
//       ),
//     );
//   }

//   Widget buildEditableField(BuildContext context, String title, String value) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//       title: Text(title),
//       trailing: GestureDetector(
//         onTap: () {
//           showEditDialog(context, title, value);
//         },
//         child: Text(
//           value,
//           style: const TextStyle(color: Colors.blue),
//         ),
//       ),
//     );
//   }

//   void showSaveDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Save'),
//           content: Row(
//             children: [
//               Checkbox(
//                 value: updateDailyNutrients,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     updateDailyNutrients = value ?? true;
//                   });
//                   Navigator.of(context).pop(); // Close the dialog temporarily
//                   showSaveDialog(
//                       context); // Reopen the dialog with updated state
//                 },
//               ),
//               const Expanded(
//                 child: Text('Update daily nutrients'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Handle the save action
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
