export default {
	async AddNewContainer (){
		let containerLabel = ContainerLabelInput.text;
		let autoGenLabel = AutoGenLabel.text;

		if(!containerLabel || !autoGenLabel ){
			showAlert("Size not selected or Description missing", "error")
		}
		// Insert the record to DB
		const response = await	AddBox.run({
			"label":"containerLabel" , 
			"code" :"autoGenLabel" , 
			"qrfile":""	 
		});
		console.log(response)
	},
	SetAutogenLabel () {
		//	write code here 
		let boxSize = BoxSizeDropDown.selectedOptionValue;
		let currentCount = BoxCount.data[0].count;
		let label = boxSize+currentCount.toString().padStart(4, '0');

		AutoGenLabel.setValue(label);

	}
}