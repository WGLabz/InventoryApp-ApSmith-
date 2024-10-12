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
			// Clear the Add new Popup
			resetWidget(Add_New_Box.name, true);
			closeModal(Add_New_Box.name);
			GetBoxes.run();
			BoxCount.run();
		}).catch(e => {
			showAlert('Failed to add the container!','error')
		});
		return 1;
	},
	async SetAutogenLabel () {
		//	write code here 
		let boxSize = BoxSizeDropDown.selectedOptionValue;
		let currentCount = NextBoxID.data[0].count;
		let label = boxSize+currentCount.toString().padStart(4, '0');

		AutoGenLabel.setValue(label);

		return 1;
	},
	async RemoveContainer(){
		RemoveContainer.run().then( r =>{
			showAlert('Removed the container sucessfully!','success');
			GetBoxes.run();
			BoxCount.run();
		}).catch(e => {
			showAlert('Failed to remove the container!','error')
		});
	},
	async UpdateContainer(){
		UpdateContainer.run().then( r =>{
			showAlert('Updated the container sucessfully!','success');
			GetBoxes.run()
			closeModal(Update_Box.name);
			GetBoxes.run();
			resetWidget(Update_Box.name, true);
		}).catch(e => {
			showAlert('Failed to update the container!','error')
		});
	}
}