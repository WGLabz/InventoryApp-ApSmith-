export default {
	AddNewContainer (){
		let containerLabel = ContainerLabelInput.text;
		let autoGenLabel = AutoGenLabel.text;

		if(!containerLabel || !autoGenLabel ){
			showAlert("Size not selected or Description missing", "error")
		}
		// Insert the record to DB
		AddBox.run().then( r =>{
			showAlert('Added the container sucessfully!','success');
			closeModal(Add_New_Box.name);
		}).catch(e => {
			showAlert('Failed to add the container!','error')
		});
		return 1;
	},
	async SetAutogenLabel () {
		//	write code here 
		let boxSize = BoxSizeDropDown.selectedOptionValue;
		let currentCount = BoxCount.data[0].count;
		let label = boxSize+currentCount.toString().padStart(4, '0');

		AutoGenLabel.setValue(label);

		return 1;
	}
}