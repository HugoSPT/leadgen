<?php

if(isset($_POST))
    echo $_POST['string'];
	
	require_once('../database.php');

	class Entry {
		
		protected static $table_name = "entries";
		protected static $db_fields = array('id', 'quantia', 'prazo',
                                'data_pagamento', 'primeiro_nome', 'ultimo_nome',
                                'data_nascimento', 'morada', 'cidade', 'CEP',
                                'telefone', 'telemovel', 'email', 'situacao_profissional',
                                'salario', 'empresa', 'contrato', 'periodo_pagamento',
                                'banco', 'num_conta', 'cartao');
		protected static $db_types = "iss";

		public $id;
		public $quantia;
		public $prazo;
                public $data_pagamento;
                public $primeiro_nome;
                public $ultimo_nome;
                public $data_nascimento;
                public $morada;
                public $cidade;
                public $CEP;
                public $telefone;
                public $telemovel;
                public $email;
                public $ituacao_profissional;
                public $salario;
                public $empresa;
                public $contrato;
                public $periodo_pagamento;
                public $banco;
                public $num_conta;
                public $cartao;
		
		public static function find_by_term($term){
			$sql = "SELECT * FROM ".self::$table_name." WHERE ";
			$terms = explode(" ",strtolower(remove_accents($term)));
			$total = count($terms);
			$types = "";
			$values = array();
			for($i = 0; $i < $total; $i++){
				if($i == 0)
					$sql .= "search LIKE CONCAT('%',?,'%')";
				else
					$sql .= " AND search LIKE CONCAT('%',?,'%')";
				$values[] = $database->escape_value($term[$i]);
				$types .= "s";
			}
			$result_array = self::find_by_sql($sql, $values, $types);
		}

		//DB METHODS
		public static function find_all() {
			return self::find_by_sql("SELECT * FROM ".self::$table_name);
	  	}

	  	public static function find_by_sql($sql="", $params=false, $types=false) {
	    	global $database;
	    	$result_set = $database->query($sql, $params, $types);
	    	$object_array = array();
	    	foreach ($result_set as $row)
	      		$object_array[] = self::instantiate($row);
	    	return $object_array;
	  	}
	
		public static function count_all() {
			global $database;
			$sql = "SELECT COUNT(*) FROM ".self::$table_name;
			$row = $database->query($sql, false, false);
			return array_shift($row);
		}

		private static function instantiate($record) {
	    	$object = new self;
			foreach($record as $attribute=>$value)
			  if($object->has_attribute($attribute))
			    $object->$attribute = $value;
			return $object;
		}

		private function has_attribute($attribute) {
		  	$object_vars = $this->attributes();
		  	return array_key_exists($attribute, $object_vars);
		}

		protected function attributes() {
			$attributes = array();
			foreach(self::$db_fields as $field)
				if(property_exists($this, $field))
					$attributes[$field] = $this->$field;
			return $attributes;
		}

		protected function sanitized_attributes() {
			global $database;
			$clean_attributes = array();
			$attributes = $this->attributes();
			foreach($attributes as $key => $value)
				$clean_attributes[$key] = $database->escape_value($value);
			return $clean_attributes;
		}

		public function save() {
			return isset($this->id) ? $this->update() : $this->create();
		}

		protected function create() {			
			global $database;

			$attributes = $this->sanitized_attributes();

		  	$sql = "INSERT INTO ".self::$table_name." (";
		  	$sql .= join(", ", array_keys($attributes));
		  	$sql .= ") VALUES (";
		  	
		  	$atts = count($attributes);
		  	
		  	for($i = 1; $i < $atts; $i++)
		  		$sql .= "?, ";
		  	
			$sql .= "?)";

		  	if($database->query($sql, $attributes, self::$db_types)){
		    	$this->id = $database->insert_id();
		    	return true;
		    }
		    
		    return false;
		}

		protected function update() {
			global $database;

			$attributes = $this->sanitized_attributes();
			$attribute_pairs = array();

			foreach($attributes as $key => $value)
				$attribute_pairs[] = $key . "=?";

			$sql = "UPDATE ".self::$table_name." SET ";
		  	$sql .= join(", ", $attribute_pairs);
			$sql .= " WHERE id = ?";
							
			$attributes[] = $database->escape_value($this->id);
			$n_types = self::$db_types."i";

		  	$database->query($sql, $attributes, $n_types);
		    return ($database->affected_rows() == 1) ? true : false;
		}

		public function delete() {
			global $database;
			$sql = "DELETE FROM ".self::$table_name;
			$sql .= " WHERE id = ? LIMIT 1";
			$database->query($sql, array($database->escape_value($this->id)), "i");
		    return ($database->affected_rows() == 1) ? true : false;
		}
	}


?>