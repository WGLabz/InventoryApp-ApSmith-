export default {
	consume(){
		let usageType = UsageType.selectedOptionValue;
		let details = Input1Copy.text;
		let qunaity = Input1.text;
		let component = SelectedCmponent.selectedOptionValue;
		let project = Select1.selectedOptionValue;

		if(usageType === "PROJECT"){
			if(!project){
				showAlert('Please select a project','error');
				return;
			}
			AddComponentToProject.run({
				projectid: project,
				componentid: component,
				quantity:qunaity
			}).then( () =>{
				showAlert('Component added to the project','success');
			}).catch( e =>{
				showAlert('Failed to add component to the project','error');
			})
		}else if(usageType === "SINGLE"){			
			if(!details){
				showAlert('Please add details of the component cosnumption','error');
				return;
			}
			ConsumeComponent.run({
				componentid: component,
				quantity:qunaity,
				purpose: details
			}).then( () =>{
				showAlert('Component consumed','success');
			}).catch( e =>{
				showAlert('Failed to consume the component','error');
			})
		}
		else{
			showAlert('Select a usage type','error');
		}
	}
}