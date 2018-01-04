<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */
	public function index()
	{
		$this->load->view('welcome_message');
	}

	public function kirim_email()
	{
		// Konfigurasi email.
		$config = [
	           'protocol'  => 'smtp',
	           'smtp_host' => 'ssl://smtp.gmail.com',
	           'smtp_port' => 465,
	           'smtp_user' => 'm45rud.project@gmail.com',	// Ganti dengan email gmail Anda.
	           'smtp_pass' => '**************',				// Password gmail Anda.
	           'mailtype'  => 'html',
	           'charset'   => 'iso-8859-1',
			   'smtp_crypto' => 'SSL',
			   'crlf'	   => "\r\n",
			   'newline'   => "\r\n",
			   'wordwrap'  => TRUE
	       ];

		// Load library email dan konfigurasinya.
	   	$this->load->library('email', $config);

		// Pengirim dan penerima email.
		$this->email->from('no-reply@masrud.com', 'MasRud.com');	// Email dan nama pegirim.
		$this->email->to('m45rud@gmail.com');						// Penerima email.

		// Subject email.
		$this->email->subject('Kirim Email Pada CodeIgniter');

		// Isi email. Bisa dengan format html.
		$this->email->message('Ini adalah contoh email yang dikirim melalui localhost pada CodeIgniter menggunakan SMTP email Google (Gmail).');

		if ($this->email->send())
		{
			echo 'Sukses, email berhasil dikirim!';
		}
		else
		{
			echo 'Error!, email tidak dapat dikirim!';
		}
	}
}