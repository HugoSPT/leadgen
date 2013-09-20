<?php

require("../firebaseLib.php");

class firebaseData{

	private $fb;

	public function __construct(){

		$urlFire = "https://leadgen.firebaseio.com/";
		$token = "iocMLyM2GuILmOBvYo99aVhoFFI2xQw41yAJk2b0";

		$this->fb = new fireBase($urlFire, $token);
			
	}
	public function SaveLead($leadJson){
		$length = 10;
		$random = '';
		  for ($i = 0; $i < $length; $i++) {
		    $random .= chr(rand(ord('a'), ord('z')));
		  }
		
		$todoPath = '/Lead/'. $random;
		//set sender data
		$responseSenders = $this->fb->set($todoPath, $leadJson);

	}
}