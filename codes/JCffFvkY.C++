#pragma once
#include <string>
#include <cstring>
#include <iostream>
#include <vector>


#include "coordinates.h"

#include "parse_dll.h"
#pragma comment (lib, "parse_proba.lib")
namespace Cam_Shaft {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;
	using namespace System::Drawing::Drawing2D;

	/// <summary>
	/// Summary for Cam_Shaft_Form
	/// </summary>
	public ref class Cam_Shaft_Form : public System::Windows::Forms::Form
	{
	public:
		Cam_Shaft_Form(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Cam_Shaft_Form()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::TabControl^  tabControl1;
	private: System::Windows::Forms::TabPage^  Geometry;
	private: System::Windows::Forms::TabPage^  Trajectorny;
	private: System::Windows::Forms::TabPage^  Profile;
	private: System::Windows::Forms::PictureBox^  picture_Cam_Shaft_N0;


	private: System::Windows::Forms::ComboBox^  list_Cam_Shaft;
	private: System::Windows::Forms::PictureBox^  picture_Cam_Shaft_N1;
	private: System::Windows::Forms::Label^  Precision_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  Angel_max_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  R_min_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  n_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  d_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  Y_Cam_Type_N0_label;

	private: System::Windows::Forms::Label^  X_Cam_Type_N0_label;
	private: System::Windows::Forms::TextBox^  Precision_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  Angel_max_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  R_min_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  n_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  d_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  Y_Cam_Type_N0_text;
	private: System::Windows::Forms::TextBox^  X_Cam_Type_N0_text;
	private: System::Windows::Forms::Label^  R_min_UnitOfMeasurement_Type_N0;

	private: System::Windows::Forms::Label^  n_rev_min_Type_N0;

	private: System::Windows::Forms::Label^  d_UnitOfMeasurement_Type_N0;

	private: System::Windows::Forms::Label^  Y_UnitOfMeasurement_Type_N0;

	private: System::Windows::Forms::Label^  X_UnitOfMeasurement_Type_N0;
	private: System::Windows::Forms::Label^  L_UnitOfMeasurement_Type_N0;


	private: System::Windows::Forms::TextBox^  L_Cam_Type_N0_text;
	private: System::Windows::Forms::Label^  L_Cam_Type_N0_label;
	private: System::Windows::Forms::Label^  X_UnitOfMeasurement_Type_N1;
	private: System::Windows::Forms::TextBox^  X_Cam_Type_N1_text;

	private: System::Windows::Forms::Label^  X_Cam_Type_N1_label;

	private: System::Windows::Forms::TextBox^  Precision_Cam_Type_N1_text;
	private: System::Windows::Forms::Label^  Precision_Cam_Type_N1_label;
	private: System::Windows::Forms::TextBox^  Angel_max_Cam_Type_N1_text;
	private: System::Windows::Forms::Label^  Angel_max_Cam_Type_N1_label;
	private: System::Windows::Forms::Label^  R_min_UnitOfMeasurement_Type_N1;
	private: System::Windows::Forms::TextBox^  R_min_Cam_Type_N1_text;
	private: System::Windows::Forms::Label^  R_min_Cam_Type_N1_label;
	private: System::Windows::Forms::Label^  n_rev_min_Type_N1;
	private: System::Windows::Forms::TextBox^  n_Cam_Type_N1_text;
	private: System::Windows::Forms::Label^  n_Cam_Type_N1_label;
	private: System::Windows::Forms::Label^  d_UnitOfMeasurement_Type_N1;
	private: System::Windows::Forms::TextBox^  d_Cam_Type_N1_text;
	private: System::Windows::Forms::Label^  d_Cam_Type_N1_label;
	private: System::Windows::Forms::Button^  ConstructGraph;
	private: System::Windows::Forms::TextBox^  Step_X_text;
	private: System::Windows::Forms::Label^  label1;
	private: System::Windows::Forms::TextBox^  End_X_text;

	private: System::Windows::Forms::Label^  End_X_label;
	private: System::Windows::Forms::TextBox^  Start_X_text;
	private: System::Windows::Forms::Label^  Start_X_label;
	private: System::Windows::Forms::Label^  Function_label;
	private: System::Windows::Forms::TextBox^  Function_text;
	private: System::Windows::Forms::PictureBox^  graphic;













	protected:




	protected:

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(Cam_Shaft_Form::typeid));
			this->tabControl1 = (gcnew System::Windows::Forms::TabControl());
			this->Geometry = (gcnew System::Windows::Forms::TabPage());
			this->Precision_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->Precision_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->Angel_max_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->Angel_max_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->R_min_UnitOfMeasurement_Type_N1 = (gcnew System::Windows::Forms::Label());
			this->R_min_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->R_min_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->n_rev_min_Type_N1 = (gcnew System::Windows::Forms::Label());
			this->n_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->n_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->d_UnitOfMeasurement_Type_N1 = (gcnew System::Windows::Forms::Label());
			this->d_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->d_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->X_UnitOfMeasurement_Type_N1 = (gcnew System::Windows::Forms::Label());
			this->X_Cam_Type_N1_text = (gcnew System::Windows::Forms::TextBox());
			this->X_Cam_Type_N1_label = (gcnew System::Windows::Forms::Label());
			this->L_UnitOfMeasurement_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->L_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->L_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->R_min_UnitOfMeasurement_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->n_rev_min_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->d_UnitOfMeasurement_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->Y_UnitOfMeasurement_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->X_UnitOfMeasurement_Type_N0 = (gcnew System::Windows::Forms::Label());
			this->Precision_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->Angel_max_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->R_min_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->n_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->d_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->Y_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->X_Cam_Type_N0_text = (gcnew System::Windows::Forms::TextBox());
			this->Precision_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->Angel_max_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->R_min_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->n_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->d_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->Y_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->X_Cam_Type_N0_label = (gcnew System::Windows::Forms::Label());
			this->picture_Cam_Shaft_N1 = (gcnew System::Windows::Forms::PictureBox());
			this->list_Cam_Shaft = (gcnew System::Windows::Forms::ComboBox());
			this->picture_Cam_Shaft_N0 = (gcnew System::Windows::Forms::PictureBox());
			this->Trajectorny = (gcnew System::Windows::Forms::TabPage());
			this->graphic = (gcnew System::Windows::Forms::PictureBox());
			this->ConstructGraph = (gcnew System::Windows::Forms::Button());
			this->Step_X_text = (gcnew System::Windows::Forms::TextBox());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->End_X_text = (gcnew System::Windows::Forms::TextBox());
			this->End_X_label = (gcnew System::Windows::Forms::Label());
			this->Start_X_text = (gcnew System::Windows::Forms::TextBox());
			this->Start_X_label = (gcnew System::Windows::Forms::Label());
			this->Function_label = (gcnew System::Windows::Forms::Label());
			this->Function_text = (gcnew System::Windows::Forms::TextBox());
			this->Profile = (gcnew System::Windows::Forms::TabPage());
			this->tabControl1->SuspendLayout();
			this->Geometry->SuspendLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->picture_Cam_Shaft_N1))->BeginInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->picture_Cam_Shaft_N0))->BeginInit();
			this->Trajectorny->SuspendLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->graphic))->BeginInit();
			this->SuspendLayout();
			// 
			// tabControl1
			// 
			this->tabControl1->Controls->Add(this->Geometry);
			this->tabControl1->Controls->Add(this->Trajectorny);
			this->tabControl1->Controls->Add(this->Profile);
			this->tabControl1->Location = System::Drawing::Point(5, 2);
			this->tabControl1->Name = L"tabControl1";
			this->tabControl1->SelectedIndex = 0;
			this->tabControl1->Size = System::Drawing::Size(991, 673);
			this->tabControl1->TabIndex = 0;
			// 
			// Geometry
			// 
			this->Geometry->BackColor = System::Drawing::Color::Silver;
			this->Geometry->Controls->Add(this->Precision_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->Precision_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->Angel_max_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->Angel_max_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->R_min_UnitOfMeasurement_Type_N1);
			this->Geometry->Controls->Add(this->R_min_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->R_min_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->n_rev_min_Type_N1);
			this->Geometry->Controls->Add(this->n_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->n_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->d_UnitOfMeasurement_Type_N1);
			this->Geometry->Controls->Add(this->d_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->d_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->X_UnitOfMeasurement_Type_N1);
			this->Geometry->Controls->Add(this->X_Cam_Type_N1_text);
			this->Geometry->Controls->Add(this->X_Cam_Type_N1_label);
			this->Geometry->Controls->Add(this->L_UnitOfMeasurement_Type_N0);
			this->Geometry->Controls->Add(this->L_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->L_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->R_min_UnitOfMeasurement_Type_N0);
			this->Geometry->Controls->Add(this->n_rev_min_Type_N0);
			this->Geometry->Controls->Add(this->d_UnitOfMeasurement_Type_N0);
			this->Geometry->Controls->Add(this->Y_UnitOfMeasurement_Type_N0);
			this->Geometry->Controls->Add(this->X_UnitOfMeasurement_Type_N0);
			this->Geometry->Controls->Add(this->Precision_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->Angel_max_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->R_min_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->n_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->d_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->Y_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->X_Cam_Type_N0_text);
			this->Geometry->Controls->Add(this->Precision_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->Angel_max_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->R_min_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->n_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->d_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->Y_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->X_Cam_Type_N0_label);
			this->Geometry->Controls->Add(this->picture_Cam_Shaft_N1);
			this->Geometry->Controls->Add(this->list_Cam_Shaft);
			this->Geometry->Controls->Add(this->picture_Cam_Shaft_N0);
			this->Geometry->Location = System::Drawing::Point(4, 22);
			this->Geometry->Name = L"Geometry";
			this->Geometry->Padding = System::Windows::Forms::Padding(3);
			this->Geometry->Size = System::Drawing::Size(983, 647);
			this->Geometry->TabIndex = 0;
			this->Geometry->Text = L"Geometry";
			// 
			// Precision_Cam_Type_N1_text
			// 
			this->Precision_Cam_Type_N1_text->Location = System::Drawing::Point(790, 336);
			this->Precision_Cam_Type_N1_text->Name = L"Precision_Cam_Type_N1_text";
			this->Precision_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->Precision_Cam_Type_N1_text->TabIndex = 40;
			this->Precision_Cam_Type_N1_text->Visible = false;
			// 
			// Precision_Cam_Type_N1_label
			// 
			this->Precision_Cam_Type_N1_label->AutoSize = true;
			this->Precision_Cam_Type_N1_label->Location = System::Drawing::Point(714, 343);
			this->Precision_Cam_Type_N1_label->Name = L"Precision_Cam_Type_N1_label";
			this->Precision_Cam_Type_N1_label->Size = System::Drawing::Size(56, 13);
			this->Precision_Cam_Type_N1_label->TabIndex = 39;
			this->Precision_Cam_Type_N1_label->Text = L"Precision=";
			this->Precision_Cam_Type_N1_label->Visible = false;
			// 
			// Angel_max_Cam_Type_N1_text
			// 
			this->Angel_max_Cam_Type_N1_text->Location = System::Drawing::Point(790, 310);
			this->Angel_max_Cam_Type_N1_text->Name = L"Angel_max_Cam_Type_N1_text";
			this->Angel_max_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->Angel_max_Cam_Type_N1_text->TabIndex = 38;
			this->Angel_max_Cam_Type_N1_text->Visible = false;
			// 
			// Angel_max_Cam_Type_N1_label
			// 
			this->Angel_max_Cam_Type_N1_label->AutoSize = true;
			this->Angel_max_Cam_Type_N1_label->Location = System::Drawing::Point(708, 317);
			this->Angel_max_Cam_Type_N1_label->Name = L"Angel_max_Cam_Type_N1_label";
			this->Angel_max_Cam_Type_N1_label->Size = System::Drawing::Size(62, 13);
			this->Angel_max_Cam_Type_N1_label->TabIndex = 37;
			this->Angel_max_Cam_Type_N1_label->Text = L"Angel max=";
			this->Angel_max_Cam_Type_N1_label->Visible = false;
			// 
			// R_min_UnitOfMeasurement_Type_N1
			// 
			this->R_min_UnitOfMeasurement_Type_N1->AutoSize = true;
			this->R_min_UnitOfMeasurement_Type_N1->Location = System::Drawing::Point(900, 287);
			this->R_min_UnitOfMeasurement_Type_N1->Name = L"R_min_UnitOfMeasurement_Type_N1";
			this->R_min_UnitOfMeasurement_Type_N1->Size = System::Drawing::Size(26, 13);
			this->R_min_UnitOfMeasurement_Type_N1->TabIndex = 36;
			this->R_min_UnitOfMeasurement_Type_N1->Text = L"mm.";
			this->R_min_UnitOfMeasurement_Type_N1->Visible = false;
			// 
			// R_min_Cam_Type_N1_text
			// 
			this->R_min_Cam_Type_N1_text->Location = System::Drawing::Point(790, 284);
			this->R_min_Cam_Type_N1_text->Name = L"R_min_Cam_Type_N1_text";
			this->R_min_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->R_min_Cam_Type_N1_text->TabIndex = 35;
			this->R_min_Cam_Type_N1_text->Visible = false;
			// 
			// R_min_Cam_Type_N1_label
			// 
			this->R_min_Cam_Type_N1_label->AutoSize = true;
			this->R_min_Cam_Type_N1_label->Location = System::Drawing::Point(730, 287);
			this->R_min_Cam_Type_N1_label->Name = L"R_min_Cam_Type_N1_label";
			this->R_min_Cam_Type_N1_label->Size = System::Drawing::Size(40, 13);
			this->R_min_Cam_Type_N1_label->TabIndex = 34;
			this->R_min_Cam_Type_N1_label->Text = L"R min=";
			this->R_min_Cam_Type_N1_label->Visible = false;
			// 
			// n_rev_min_Type_N1
			// 
			this->n_rev_min_Type_N1->AutoSize = true;
			this->n_rev_min_Type_N1->Location = System::Drawing::Point(900, 265);
			this->n_rev_min_Type_N1->Name = L"n_rev_min_Type_N1";
			this->n_rev_min_Type_N1->Size = System::Drawing::Size(43, 13);
			this->n_rev_min_Type_N1->TabIndex = 33;
			this->n_rev_min_Type_N1->Text = L"rev/min";
			this->n_rev_min_Type_N1->Visible = false;
			// 
			// n_Cam_Type_N1_text
			// 
			this->n_Cam_Type_N1_text->Location = System::Drawing::Point(790, 258);
			this->n_Cam_Type_N1_text->Name = L"n_Cam_Type_N1_text";
			this->n_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->n_Cam_Type_N1_text->TabIndex = 32;
			this->n_Cam_Type_N1_text->Visible = false;
			// 
			// n_Cam_Type_N1_label
			// 
			this->n_Cam_Type_N1_label->AutoSize = true;
			this->n_Cam_Type_N1_label->Location = System::Drawing::Point(751, 265);
			this->n_Cam_Type_N1_label->Name = L"n_Cam_Type_N1_label";
			this->n_Cam_Type_N1_label->Size = System::Drawing::Size(19, 13);
			this->n_Cam_Type_N1_label->TabIndex = 31;
			this->n_Cam_Type_N1_label->Text = L"n=";
			this->n_Cam_Type_N1_label->Visible = false;
			// 
			// d_UnitOfMeasurement_Type_N1
			// 
			this->d_UnitOfMeasurement_Type_N1->AutoSize = true;
			this->d_UnitOfMeasurement_Type_N1->Location = System::Drawing::Point(900, 237);
			this->d_UnitOfMeasurement_Type_N1->Name = L"d_UnitOfMeasurement_Type_N1";
			this->d_UnitOfMeasurement_Type_N1->Size = System::Drawing::Size(26, 13);
			this->d_UnitOfMeasurement_Type_N1->TabIndex = 30;
			this->d_UnitOfMeasurement_Type_N1->Text = L"mm.";
			this->d_UnitOfMeasurement_Type_N1->Visible = false;
			// 
			// d_Cam_Type_N1_text
			// 
			this->d_Cam_Type_N1_text->Location = System::Drawing::Point(790, 230);
			this->d_Cam_Type_N1_text->Name = L"d_Cam_Type_N1_text";
			this->d_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->d_Cam_Type_N1_text->TabIndex = 29;
			this->d_Cam_Type_N1_text->Visible = false;
			// 
			// d_Cam_Type_N1_label
			// 
			this->d_Cam_Type_N1_label->AutoSize = true;
			this->d_Cam_Type_N1_label->Location = System::Drawing::Point(751, 233);
			this->d_Cam_Type_N1_label->Name = L"d_Cam_Type_N1_label";
			this->d_Cam_Type_N1_label->Size = System::Drawing::Size(19, 13);
			this->d_Cam_Type_N1_label->TabIndex = 28;
			this->d_Cam_Type_N1_label->Text = L"d=";
			this->d_Cam_Type_N1_label->Visible = false;
			// 
			// X_UnitOfMeasurement_Type_N1
			// 
			this->X_UnitOfMeasurement_Type_N1->AutoSize = true;
			this->X_UnitOfMeasurement_Type_N1->Location = System::Drawing::Point(900, 211);
			this->X_UnitOfMeasurement_Type_N1->Name = L"X_UnitOfMeasurement_Type_N1";
			this->X_UnitOfMeasurement_Type_N1->Size = System::Drawing::Size(26, 13);
			this->X_UnitOfMeasurement_Type_N1->TabIndex = 27;
			this->X_UnitOfMeasurement_Type_N1->Text = L"mm.";
			this->X_UnitOfMeasurement_Type_N1->Visible = false;
			// 
			// X_Cam_Type_N1_text
			// 
			this->X_Cam_Type_N1_text->Location = System::Drawing::Point(790, 204);
			this->X_Cam_Type_N1_text->Name = L"X_Cam_Type_N1_text";
			this->X_Cam_Type_N1_text->Size = System::Drawing::Size(100, 20);
			this->X_Cam_Type_N1_text->TabIndex = 26;
			this->X_Cam_Type_N1_text->Visible = false;
			// 
			// X_Cam_Type_N1_label
			// 
			this->X_Cam_Type_N1_label->AutoSize = true;
			this->X_Cam_Type_N1_label->Location = System::Drawing::Point(750, 209);
			this->X_Cam_Type_N1_label->Name = L"X_Cam_Type_N1_label";
			this->X_Cam_Type_N1_label->Size = System::Drawing::Size(20, 13);
			this->X_Cam_Type_N1_label->TabIndex = 25;
			this->X_Cam_Type_N1_label->Text = L"X=";
			this->X_Cam_Type_N1_label->Visible = false;
			// 
			// L_UnitOfMeasurement_Type_N0
			// 
			this->L_UnitOfMeasurement_Type_N0->AutoSize = true;
			this->L_UnitOfMeasurement_Type_N0->Location = System::Drawing::Point(900, 262);
			this->L_UnitOfMeasurement_Type_N0->Name = L"L_UnitOfMeasurement_Type_N0";
			this->L_UnitOfMeasurement_Type_N0->Size = System::Drawing::Size(26, 13);
			this->L_UnitOfMeasurement_Type_N0->TabIndex = 24;
			this->L_UnitOfMeasurement_Type_N0->Text = L"mm.";
			this->L_UnitOfMeasurement_Type_N0->Visible = false;
			// 
			// L_Cam_Type_N0_text
			// 
			this->L_Cam_Type_N0_text->Location = System::Drawing::Point(790, 259);
			this->L_Cam_Type_N0_text->Name = L"L_Cam_Type_N0_text";
			this->L_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->L_Cam_Type_N0_text->TabIndex = 23;
			this->L_Cam_Type_N0_text->Visible = false;
			// 
			// L_Cam_Type_N0_label
			// 
			this->L_Cam_Type_N0_label->AutoSize = true;
			this->L_Cam_Type_N0_label->Location = System::Drawing::Point(751, 262);
			this->L_Cam_Type_N0_label->Name = L"L_Cam_Type_N0_label";
			this->L_Cam_Type_N0_label->Size = System::Drawing::Size(19, 13);
			this->L_Cam_Type_N0_label->TabIndex = 22;
			this->L_Cam_Type_N0_label->Text = L"L=";
			this->L_Cam_Type_N0_label->Visible = false;
			// 
			// R_min_UnitOfMeasurement_Type_N0
			// 
			this->R_min_UnitOfMeasurement_Type_N0->AutoSize = true;
			this->R_min_UnitOfMeasurement_Type_N0->Location = System::Drawing::Point(900, 339);
			this->R_min_UnitOfMeasurement_Type_N0->Name = L"R_min_UnitOfMeasurement_Type_N0";
			this->R_min_UnitOfMeasurement_Type_N0->Size = System::Drawing::Size(26, 13);
			this->R_min_UnitOfMeasurement_Type_N0->TabIndex = 21;
			this->R_min_UnitOfMeasurement_Type_N0->Text = L"mm.";
			this->R_min_UnitOfMeasurement_Type_N0->Visible = false;
			// 
			// n_rev_min_Type_N0
			// 
			this->n_rev_min_Type_N0->AutoSize = true;
			this->n_rev_min_Type_N0->Location = System::Drawing::Point(900, 313);
			this->n_rev_min_Type_N0->Name = L"n_rev_min_Type_N0";
			this->n_rev_min_Type_N0->Size = System::Drawing::Size(43, 13);
			this->n_rev_min_Type_N0->TabIndex = 20;
			this->n_rev_min_Type_N0->Text = L"rev/min";
			this->n_rev_min_Type_N0->Visible = false;
			// 
			// d_UnitOfMeasurement_Type_N0
			// 
			this->d_UnitOfMeasurement_Type_N0->AutoSize = true;
			this->d_UnitOfMeasurement_Type_N0->Location = System::Drawing::Point(900, 284);
			this->d_UnitOfMeasurement_Type_N0->Name = L"d_UnitOfMeasurement_Type_N0";
			this->d_UnitOfMeasurement_Type_N0->Size = System::Drawing::Size(26, 13);
			this->d_UnitOfMeasurement_Type_N0->TabIndex = 19;
			this->d_UnitOfMeasurement_Type_N0->Text = L"mm.";
			this->d_UnitOfMeasurement_Type_N0->Visible = false;
			// 
			// Y_UnitOfMeasurement_Type_N0
			// 
			this->Y_UnitOfMeasurement_Type_N0->AutoSize = true;
			this->Y_UnitOfMeasurement_Type_N0->Location = System::Drawing::Point(900, 237);
			this->Y_UnitOfMeasurement_Type_N0->Name = L"Y_UnitOfMeasurement_Type_N0";
			this->Y_UnitOfMeasurement_Type_N0->Size = System::Drawing::Size(26, 13);
			this->Y_UnitOfMeasurement_Type_N0->TabIndex = 18;
			this->Y_UnitOfMeasurement_Type_N0->Text = L"mm.";
			this->Y_UnitOfMeasurement_Type_N0->Visible = false;
			// 
			// X_UnitOfMeasurement_Type_N0
			// 
			this->X_UnitOfMeasurement_Type_N0->AutoSize = true;
			this->X_UnitOfMeasurement_Type_N0->Location = System::Drawing::Point(900, 209);
			this->X_UnitOfMeasurement_Type_N0->Name = L"X_UnitOfMeasurement_Type_N0";
			this->X_UnitOfMeasurement_Type_N0->Size = System::Drawing::Size(26, 13);
			this->X_UnitOfMeasurement_Type_N0->TabIndex = 17;
			this->X_UnitOfMeasurement_Type_N0->Text = L"mm.";
			this->X_UnitOfMeasurement_Type_N0->Visible = false;
			// 
			// Precision_Cam_Type_N0_text
			// 
			this->Precision_Cam_Type_N0_text->Location = System::Drawing::Point(790, 388);
			this->Precision_Cam_Type_N0_text->Name = L"Precision_Cam_Type_N0_text";
			this->Precision_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->Precision_Cam_Type_N0_text->TabIndex = 16;
			this->Precision_Cam_Type_N0_text->Visible = false;
			// 
			// Angel_max_Cam_Type_N0_text
			// 
			this->Angel_max_Cam_Type_N0_text->Location = System::Drawing::Point(790, 362);
			this->Angel_max_Cam_Type_N0_text->Name = L"Angel_max_Cam_Type_N0_text";
			this->Angel_max_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->Angel_max_Cam_Type_N0_text->TabIndex = 15;
			this->Angel_max_Cam_Type_N0_text->Visible = false;
			// 
			// R_min_Cam_Type_N0_text
			// 
			this->R_min_Cam_Type_N0_text->Location = System::Drawing::Point(790, 336);
			this->R_min_Cam_Type_N0_text->Name = L"R_min_Cam_Type_N0_text";
			this->R_min_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->R_min_Cam_Type_N0_text->TabIndex = 14;
			this->R_min_Cam_Type_N0_text->Visible = false;
			// 
			// n_Cam_Type_N0_text
			// 
			this->n_Cam_Type_N0_text->Location = System::Drawing::Point(790, 310);
			this->n_Cam_Type_N0_text->Name = L"n_Cam_Type_N0_text";
			this->n_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->n_Cam_Type_N0_text->TabIndex = 13;
			this->n_Cam_Type_N0_text->Visible = false;
			// 
			// d_Cam_Type_N0_text
			// 
			this->d_Cam_Type_N0_text->Location = System::Drawing::Point(790, 284);
			this->d_Cam_Type_N0_text->Name = L"d_Cam_Type_N0_text";
			this->d_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->d_Cam_Type_N0_text->TabIndex = 12;
			this->d_Cam_Type_N0_text->Visible = false;
			// 
			// Y_Cam_Type_N0_text
			// 
			this->Y_Cam_Type_N0_text->Location = System::Drawing::Point(790, 230);
			this->Y_Cam_Type_N0_text->Name = L"Y_Cam_Type_N0_text";
			this->Y_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->Y_Cam_Type_N0_text->TabIndex = 11;
			this->Y_Cam_Type_N0_text->Visible = false;
			// 
			// X_Cam_Type_N0_text
			// 
			this->X_Cam_Type_N0_text->Location = System::Drawing::Point(790, 204);
			this->X_Cam_Type_N0_text->Name = L"X_Cam_Type_N0_text";
			this->X_Cam_Type_N0_text->Size = System::Drawing::Size(100, 20);
			this->X_Cam_Type_N0_text->TabIndex = 10;
			this->X_Cam_Type_N0_text->Visible = false;
			// 
			// Precision_Cam_Type_N0_label
			// 
			this->Precision_Cam_Type_N0_label->AutoSize = true;
			this->Precision_Cam_Type_N0_label->Location = System::Drawing::Point(714, 388);
			this->Precision_Cam_Type_N0_label->Name = L"Precision_Cam_Type_N0_label";
			this->Precision_Cam_Type_N0_label->Size = System::Drawing::Size(56, 13);
			this->Precision_Cam_Type_N0_label->TabIndex = 9;
			this->Precision_Cam_Type_N0_label->Text = L"Precision=";
			this->Precision_Cam_Type_N0_label->Visible = false;
			// 
			// Angel_max_Cam_Type_N0_label
			// 
			this->Angel_max_Cam_Type_N0_label->AutoSize = true;
			this->Angel_max_Cam_Type_N0_label->Location = System::Drawing::Point(708, 362);
			this->Angel_max_Cam_Type_N0_label->Name = L"Angel_max_Cam_Type_N0_label";
			this->Angel_max_Cam_Type_N0_label->Size = System::Drawing::Size(62, 13);
			this->Angel_max_Cam_Type_N0_label->TabIndex = 8;
			this->Angel_max_Cam_Type_N0_label->Text = L"Angle max=";
			this->Angel_max_Cam_Type_N0_label->Visible = false;
			// 
			// R_min_Cam_Type_N0_label
			// 
			this->R_min_Cam_Type_N0_label->AutoSize = true;
			this->R_min_Cam_Type_N0_label->Location = System::Drawing::Point(730, 343);
			this->R_min_Cam_Type_N0_label->Name = L"R_min_Cam_Type_N0_label";
			this->R_min_Cam_Type_N0_label->Size = System::Drawing::Size(40, 13);
			this->R_min_Cam_Type_N0_label->TabIndex = 7;
			this->R_min_Cam_Type_N0_label->Text = L"R min=";
			this->R_min_Cam_Type_N0_label->Visible = false;
			// 
			// n_Cam_Type_N0_label
			// 
			this->n_Cam_Type_N0_label->AutoSize = true;
			this->n_Cam_Type_N0_label->Location = System::Drawing::Point(751, 317);
			this->n_Cam_Type_N0_label->Name = L"n_Cam_Type_N0_label";
			this->n_Cam_Type_N0_label->Size = System::Drawing::Size(19, 13);
			this->n_Cam_Type_N0_label->TabIndex = 6;
			this->n_Cam_Type_N0_label->Text = L"n=";
			this->n_Cam_Type_N0_label->Visible = false;
			// 
			// d_Cam_Type_N0_label
			// 
			this->d_Cam_Type_N0_label->AutoSize = true;
			this->d_Cam_Type_N0_label->Location = System::Drawing::Point(751, 287);
			this->d_Cam_Type_N0_label->Name = L"d_Cam_Type_N0_label";
			this->d_Cam_Type_N0_label->Size = System::Drawing::Size(19, 13);
			this->d_Cam_Type_N0_label->TabIndex = 5;
			this->d_Cam_Type_N0_label->Text = L"d=";
			this->d_Cam_Type_N0_label->Visible = false;
			// 
			// Y_Cam_Type_N0_label
			// 
			this->Y_Cam_Type_N0_label->AutoSize = true;
			this->Y_Cam_Type_N0_label->Location = System::Drawing::Point(750, 237);
			this->Y_Cam_Type_N0_label->Name = L"Y_Cam_Type_N0_label";
			this->Y_Cam_Type_N0_label->Size = System::Drawing::Size(20, 13);
			this->Y_Cam_Type_N0_label->TabIndex = 4;
			this->Y_Cam_Type_N0_label->Text = L"Y=";
			this->Y_Cam_Type_N0_label->Visible = false;
			// 
			// X_Cam_Type_N0_label
			// 
			this->X_Cam_Type_N0_label->AutoSize = true;
			this->X_Cam_Type_N0_label->Location = System::Drawing::Point(750, 209);
			this->X_Cam_Type_N0_label->Name = L"X_Cam_Type_N0_label";
			this->X_Cam_Type_N0_label->Size = System::Drawing::Size(20, 13);
			this->X_Cam_Type_N0_label->TabIndex = 3;
			this->X_Cam_Type_N0_label->Text = L"X=";
			this->X_Cam_Type_N0_label->Visible = false;
			// 
			// picture_Cam_Shaft_N1
			// 
			this->picture_Cam_Shaft_N1->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"picture_Cam_Shaft_N1.Image")));
			this->picture_Cam_Shaft_N1->Location = System::Drawing::Point(126, 160);
			this->picture_Cam_Shaft_N1->Name = L"picture_Cam_Shaft_N1";
			this->picture_Cam_Shaft_N1->Size = System::Drawing::Size(401, 423);
			this->picture_Cam_Shaft_N1->TabIndex = 2;
			this->picture_Cam_Shaft_N1->TabStop = false;
			this->picture_Cam_Shaft_N1->Visible = false;
			// 
			// list_Cam_Shaft
			// 
			this->list_Cam_Shaft->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->list_Cam_Shaft->FormattingEnabled = true;
			this->list_Cam_Shaft->Items->AddRange(gcnew cli::array< System::Object^  >(2) { L"Cam Type N0 (balance)", L"Cam Type N1 (with the thruster)" });
			this->list_Cam_Shaft->Location = System::Drawing::Point(717, 160);
			this->list_Cam_Shaft->Name = L"list_Cam_Shaft";
			this->list_Cam_Shaft->Size = System::Drawing::Size(218, 21);
			this->list_Cam_Shaft->TabIndex = 1;
			this->list_Cam_Shaft->SelectedIndexChanged += gcnew System::EventHandler(this, &Cam_Shaft_Form::list_Cam_Shaft_SelectedIndexChanged);
			// 
			// picture_Cam_Shaft_N0
			// 
			this->picture_Cam_Shaft_N0->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"picture_Cam_Shaft_N0.Image")));
			this->picture_Cam_Shaft_N0->Location = System::Drawing::Point(126, 160);
			this->picture_Cam_Shaft_N0->Name = L"picture_Cam_Shaft_N0";
			this->picture_Cam_Shaft_N0->Size = System::Drawing::Size(401, 423);
			this->picture_Cam_Shaft_N0->TabIndex = 0;
			this->picture_Cam_Shaft_N0->TabStop = false;
			this->picture_Cam_Shaft_N0->Visible = false;
			// 
			// Trajectorny
			// 
			this->Trajectorny->BackColor = System::Drawing::Color::Silver;
			this->Trajectorny->Controls->Add(this->graphic);
			this->Trajectorny->Controls->Add(this->ConstructGraph);
			this->Trajectorny->Controls->Add(this->Step_X_text);
			this->Trajectorny->Controls->Add(this->label1);
			this->Trajectorny->Controls->Add(this->End_X_text);
			this->Trajectorny->Controls->Add(this->End_X_label);
			this->Trajectorny->Controls->Add(this->Start_X_text);
			this->Trajectorny->Controls->Add(this->Start_X_label);
			this->Trajectorny->Controls->Add(this->Function_label);
			this->Trajectorny->Controls->Add(this->Function_text);
			this->Trajectorny->Location = System::Drawing::Point(4, 22);
			this->Trajectorny->Name = L"Trajectorny";
			this->Trajectorny->Padding = System::Windows::Forms::Padding(3);
			this->Trajectorny->Size = System::Drawing::Size(983, 647);
			this->Trajectorny->TabIndex = 1;
			this->Trajectorny->Text = L"Trajectorny";
			// 
			// graphic
			// 
			this->graphic->Location = System::Drawing::Point(34, 30);
			this->graphic->Name = L"graphic";
			this->graphic->Size = System::Drawing::Size(650, 600);
			this->graphic->TabIndex = 9;
			this->graphic->TabStop = false;
			this->graphic->MouseDown += gcnew System::Windows::Forms::MouseEventHandler(this, &Cam_Shaft_Form::graphic_MouseDown);
			// 
			// ConstructGraph
			// 
			this->ConstructGraph->Location = System::Drawing::Point(731, 228);
			this->ConstructGraph->Name = L"ConstructGraph";
			this->ConstructGraph->Size = System::Drawing::Size(205, 23);
			this->ConstructGraph->TabIndex = 8;
			this->ConstructGraph->Text = L"Construct a graph";
			this->ConstructGraph->UseVisualStyleBackColor = true;
			this->ConstructGraph->Click += gcnew System::EventHandler(this, &Cam_Shaft_Form::ConstructGraph_Click);
			// 
			// Step_X_text
			// 
			this->Step_X_text->Location = System::Drawing::Point(926, 202);
			this->Step_X_text->Name = L"Step_X_text";
			this->Step_X_text->Size = System::Drawing::Size(38, 20);
			this->Step_X_text->TabIndex = 7;
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(877, 205);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(45, 13);
			this->label1->TabIndex = 6;
			this->label1->Text = L"Step X=";
			// 
			// End_X_text
			// 
			this->End_X_text->Location = System::Drawing::Point(833, 202);
			this->End_X_text->Name = L"End_X_text";
			this->End_X_text->Size = System::Drawing::Size(38, 20);
			this->End_X_text->TabIndex = 5;
			// 
			// End_X_label
			// 
			this->End_X_label->AutoSize = true;
			this->End_X_label->Location = System::Drawing::Point(785, 205);
			this->End_X_label->Name = L"End_X_label";
			this->End_X_label->Size = System::Drawing::Size(42, 13);
			this->End_X_label->TabIndex = 4;
			this->End_X_label->Text = L"End X=";
			// 
			// Start_X_text
			// 
			this->Start_X_text->Location = System::Drawing::Point(741, 202);
			this->Start_X_text->Name = L"Start_X_text";
			this->Start_X_text->Size = System::Drawing::Size(38, 20);
			this->Start_X_text->TabIndex = 3;
			// 
			// Start_X_label
			// 
			this->Start_X_label->AutoSize = true;
			this->Start_X_label->Location = System::Drawing::Point(690, 205);
			this->Start_X_label->Name = L"Start_X_label";
			this->Start_X_label->Size = System::Drawing::Size(45, 13);
			this->Start_X_label->TabIndex = 2;
			this->Start_X_label->Text = L"Start X=";
			// 
			// Function_label
			// 
			this->Function_label->AutoSize = true;
			this->Function_label->Location = System::Drawing::Point(690, 165);
			this->Function_label->Name = L"Function_label";
			this->Function_label->Size = System::Drawing::Size(31, 13);
			this->Function_label->TabIndex = 1;
			this->Function_label->Text = L"Y(x)=";
			// 
			// Function_text
			// 
			this->Function_text->Location = System::Drawing::Point(731, 162);
			this->Function_text->Name = L"Function_text";
			this->Function_text->Size = System::Drawing::Size(205, 20);
			this->Function_text->TabIndex = 0;
			// 
			// Profile
			// 
			this->Profile->BackColor = System::Drawing::Color::Silver;
			this->Profile->Location = System::Drawing::Point(4, 22);
			this->Profile->Name = L"Profile";
			this->Profile->Size = System::Drawing::Size(983, 647);
			this->Profile->TabIndex = 2;
			this->Profile->Text = L"Profile";
			// 
			// Cam_Shaft_Form
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(1008, 687);
			this->Controls->Add(this->tabControl1);
			this->MaximumSize = System::Drawing::Size(1024, 7689);
			this->MinimumSize = System::Drawing::Size(1024, 726);
			this->Name = L"Cam_Shaft_Form";
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = L"Cam_Shaft";
			this->tabControl1->ResumeLayout(false);
			this->Geometry->ResumeLayout(false);
			this->Geometry->PerformLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->picture_Cam_Shaft_N1))->EndInit();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->picture_Cam_Shaft_N0))->EndInit();
			this->Trajectorny->ResumeLayout(false);
			this->Trajectorny->PerformLayout();
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->graphic))->EndInit();
			this->ResumeLayout(false);

		}
#pragma endregion
	
	private: System::Void list_Cam_Shaft_SelectedIndexChanged(System::Object^  sender, System::EventArgs^  e) {
		if (list_Cam_Shaft->SelectedIndex == 0){
			picture_Cam_Shaft_N0->Visible = true;
			X_Cam_Type_N0_label->Visible = true;
			X_Cam_Type_N0_text->Visible = true;
			X_UnitOfMeasurement_Type_N0->Visible = true;
			Y_Cam_Type_N0_label->Visible = true;
			Y_Cam_Type_N0_text->Visible = true;
			Y_UnitOfMeasurement_Type_N0->Visible = true;
			L_Cam_Type_N0_label->Visible = true;
			L_Cam_Type_N0_text->Visible = true;
			L_UnitOfMeasurement_Type_N0->Visible = true;
			d_Cam_Type_N0_label->Visible = true;
			d_Cam_Type_N0_text->Visible = true;
			d_UnitOfMeasurement_Type_N0->Visible = true;
			n_Cam_Type_N0_label->Visible = true;
			n_Cam_Type_N0_text->Visible = true;
			n_rev_min_Type_N0->Visible = true;
			R_min_Cam_Type_N0_label->Visible = true;
			R_min_Cam_Type_N0_text->Visible = true;
			R_min_UnitOfMeasurement_Type_N0->Visible = true;
			Angel_max_Cam_Type_N0_label->Visible = true;
			Angel_max_Cam_Type_N0_text->Visible = true;
			Precision_Cam_Type_N0_label->Visible = true;
			Precision_Cam_Type_N0_text->Visible = true;
		}
		else {
			picture_Cam_Shaft_N0->Visible = false;
			X_Cam_Type_N0_label->Visible = false;
			X_Cam_Type_N0_text->Visible = false;
			X_UnitOfMeasurement_Type_N0->Visible = false;
			Y_Cam_Type_N0_label->Visible = false;
			Y_Cam_Type_N0_text->Visible = false;
			Y_UnitOfMeasurement_Type_N0->Visible = false;
			L_Cam_Type_N0_label->Visible = false;
			L_Cam_Type_N0_text->Visible = false;
			L_UnitOfMeasurement_Type_N0->Visible = false;
			d_Cam_Type_N0_label->Visible = false;
			d_Cam_Type_N0_text->Visible = false;
			d_UnitOfMeasurement_Type_N0->Visible = false;
			n_Cam_Type_N0_label->Visible = false;
			n_Cam_Type_N0_text->Visible = false;
			n_rev_min_Type_N0->Visible = false;
			R_min_Cam_Type_N0_label->Visible = false;
			R_min_Cam_Type_N0_text->Visible = false;
			R_min_UnitOfMeasurement_Type_N0->Visible = false;
			Angel_max_Cam_Type_N0_label->Visible = false;
			Angel_max_Cam_Type_N0_text->Visible = false;
			Precision_Cam_Type_N0_label->Visible = false;
			Precision_Cam_Type_N0_text->Visible = false;
		}
		if (list_Cam_Shaft->SelectedIndex == 1){
			picture_Cam_Shaft_N1->Visible = true;
			X_Cam_Type_N1_label->Visible = true;
			X_Cam_Type_N1_text->Visible = true;
			X_UnitOfMeasurement_Type_N1->Visible = true;
			d_Cam_Type_N1_label->Visible = true;
			d_Cam_Type_N1_text->Visible = true;
			d_UnitOfMeasurement_Type_N1->Visible = true;
			n_Cam_Type_N1_label->Visible = true;
			n_Cam_Type_N1_text->Visible = true;
			n_rev_min_Type_N1->Visible = true;
			R_min_Cam_Type_N1_label->Visible = true;
			R_min_Cam_Type_N1_text->Visible = true;
			R_min_UnitOfMeasurement_Type_N1->Visible = true;
			Angel_max_Cam_Type_N1_label->Visible = true;
			Angel_max_Cam_Type_N1_text->Visible = true;
			Precision_Cam_Type_N1_label->Visible = true;
			Precision_Cam_Type_N1_text->Visible = true;
		}
		else {
			picture_Cam_Shaft_N1->Visible = false;
			X_Cam_Type_N1_label->Visible = false;
			X_Cam_Type_N1_text->Visible = false;
			X_UnitOfMeasurement_Type_N1->Visible = false;
			d_Cam_Type_N1_label->Visible = false;
			d_Cam_Type_N1_text->Visible = false;
			d_UnitOfMeasurement_Type_N1->Visible = false;
			n_Cam_Type_N1_label->Visible = false;
			n_Cam_Type_N1_text->Visible = false;
			n_rev_min_Type_N1->Visible = false;
			R_min_Cam_Type_N1_label->Visible = false;
			R_min_Cam_Type_N1_text->Visible = false;
			R_min_UnitOfMeasurement_Type_N1->Visible = false;
			Angel_max_Cam_Type_N1_label->Visible = false;
			Angel_max_Cam_Type_N1_text->Visible = false;
			Precision_Cam_Type_N1_label->Visible = false;
			Precision_Cam_Type_N1_text->Visible = false;
		}
	}
private: System::Void ConstructGraph_Click(System::Object^  sender, System::EventArgs^  e) {
	using namespace std;

	//graphic->Image = nullptr;
	//delete this->graphic->Image;
	string function;
	vector<coordinates_of_the_point> coordinates;
	coordinates_of_the_point coordinates_point[2];
	zoo_factor ration;
	int a, b, c, d,number_point=0;
	double max_X, max_Y, min_X,min_Y;
	String^ inscription_above_the_point = "";
	SolidBrush ^brush = gcnew SolidBrush(Color::Black);



	double start_X, end_X, step_X;
	start_X = System::Convert::ToDouble(Start_X_text->Text);
	end_X = System::Convert::ToDouble(End_X_text->Text);
	step_X = System::Convert::ToDouble(Step_X_text->Text);
	for (int i = 0; i< this->Function_text->Text->Length; i++)
	{
		function += this->Function_text->Text[i];
	}
	function += "\n";


	coordinates_point[0].coordinates_X = start_X;
	coordinates_point[0].coordinates_Y = parser(start_X, function);
	coordinates.push_back(coordinates_point[0]);
	start_X += step_X;
	max_X = coordinates_point[0].coordinates_X;
	max_Y = coordinates_point[0].coordinates_Y;
	min_X = coordinates_point[0].coordinates_X;
	min_Y = coordinates_point[0].coordinates_Y;

	while (start_X <= end_X)
	{
		start_X += step_X;
		coordinates_point[0].coordinates_X = start_X;
		coordinates_point[0].coordinates_Y = parser(start_X, function);
		coordinates.push_back(coordinates_point[0]);
		if (coordinates_point[0].coordinates_X > max_X)max_X = coordinates_point[0].coordinates_X;
		if (coordinates_point[0].coordinates_Y > max_Y)max_Y = coordinates_point[0].coordinates_Y;
		if (coordinates_point[0].coordinates_Y < min_Y)min_Y = coordinates_point[0].coordinates_Y;
	}


	ration.zoom_factor_X = max_X/600;
	ration.zoom_factor_Y = max_Y/580;
	if (min_X < 0)min_X = min_X*(-1) - min_X; else min_X = 0;
	if (min_Y < 0)min_Y = min_Y*(-1) - min_Y; else min_Y = 0;
	ration.zoom_factor_X = (max_X+min_X+1) / 600;
	ration.zoom_factor_Y = (max_Y+min_Y+1) / 580;
	Graphics ^g = graphic->CreateGraphics();
	Pen ^p = gcnew Pen(Color::Black,1);
	Pen ^p1 = gcnew Pen(Color::Gray, 1);
	g->Clear(Color::Silver);
	for (int i = 0; i <coordinates.size()-1; i ++)
	{
		number_point++;


		for (int i = 50; i <= 650; i += 600/50)
		{
			if ((i-50) % 60 == 0)g->DrawLine(p, i, 0, i, 585); else g->DrawLine(p1, i, 0, i, 580);
		}
		for (int i = 0; i <= 600; i += 580 / 20)
		{
			if (i % 58 == 0)g->DrawLine(p, 45, i, 650, i); else g->DrawLine(p1, 50, i, 650, i);
		}



		coordinates_point[0] = coordinates[i];
		coordinates_point[1] = coordinates[i+1];
		a = round((coordinates_point[0].coordinates_X+min_X) / ration.zoom_factor_X)+50;
		b = 600 - (round((coordinates_point[0].coordinates_Y+min_Y) / ration.zoom_factor_Y))-20;
		c = round((coordinates_point[1].coordinates_X+min_X) / ration.zoom_factor_X)+50;
		d = 600 - (round((coordinates_point[1].coordinates_Y+min_Y) / ration.zoom_factor_Y))-20;

		g->DrawLine(p, a, b, c, d);
		g->DrawLine(p, a - 4, b + 4, a + 4, b + 4);
		g->DrawLine(p, a - 4, b - 4, a + 4, b - 4);
		g->DrawLine(p, a - 4, b - 4, a - 4, b + 4);
		g->DrawLine(p, a + 4, b - 4, a + 4, b + 4);


		inscription_above_the_point = gcnew String(number_point.ToString()); 
		g->DrawString(inscription_above_the_point, Font, brush, a, b - 20);



		if (i == coordinates.size()-2)
		{
			number_point = number_point + 1;
			inscription_above_the_point = gcnew String(number_point.ToString());
			g->DrawLine(p, c - 4, d + 4, c + 4, d + 4);
			g->DrawLine(p, c - 4, d - 4, c + 4, d - 4);
			g->DrawLine(p, c - 4, d - 4, c - 4, d + 4);
			g->DrawLine(p, c + 4, d - 4, c + 4, d + 4);
			g->DrawString(inscription_above_the_point, Font, brush, c, d - 20);
		}
		
	}

	//string s = "Sample Text";
	//Font = gcnew System::Drawing::Font("Arial", 8);
	/*String^ inscription_above_the_point = "fdgkh";
	SolidBrush ^brush = gcnew SolidBrush(Color::Black);
	int x = 47;
	int у = 600-40;
	g->DrawString(inscription_above_the_point, Font, brush, x, у);*/


	/*g->DrawLine(p, 1, 1, 100, 100);
	g->DrawLine(p, 100, 100, 300, 1);*/
	//End_X_text->Text = System::Convert::ToString(parser(2.5, "2+4\n"));
	//function = System::Convert::ToString(Function_text);
	//Start_X_text->Text = System::Convert::ToString("fsdf");
	//perem=Textbox1->Text.toFloat();
	//speedtext->Text=System::Convert::ToString(200);
}
private: System::Void graphic_MouseDown(System::Object^  sender, System::Windows::Forms::MouseEventArgs^  e) {
	
}
};
}