import 'package:componentes_flutter/app/core/widgets/form_row.dart';
import 'package:componentes_flutter/app/core/widgets/submit_form_button.dart';
import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedGender;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormRow(text: 'First Name: '),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormRow(text: 'Last Name: '),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 25,
                          child: Row(children: [
                            Radio(
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                selectedGender = value;
                              },
                            ),
                            const Text('Male'),
                            Radio(
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                selectedGender = value;
                              },
                            ),
                            const Text('Female'),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormRow(text: 'Employee ID: '),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormRow(text: 'Designation: '),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormRow(text: 'Phone Number: '),
                        const SizedBox(
                          height: 20,
                        ),
                        SubmitFormButton(
                          text: 'Submit',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: -12,
                  child: Container(
                    color: Colors.white, // Fundo branco para cobrir a borda
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'Employee Details',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
