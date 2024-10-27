export default {
	async copy(){
		var exists = await CheckIfComponentExists.run({
			name: ComponentNameCopy.text
		});

		if(exists.length > 0){
			showAlert('Component already exists','error');
		}else{
			CopyComponent.run().then(() => {
				showAlert('Component duplicated','success');
			}).catch(() => {
				showAlert('Failed to duplicate component','error');
			})
		}
	},
	async add(){
		var exists = await CheckIfComponentExists.run({
			name: ComponentName.text
		});

		if(exists.length > 0){
			showAlert('Component already exists','error');
		}else{
			AddNewComponentSQL.run().then(() => {
				showAlert('Component added','success');
			}).catch(() => {
				showAlert('Failed to add component','error');
			})
		}

	}
}