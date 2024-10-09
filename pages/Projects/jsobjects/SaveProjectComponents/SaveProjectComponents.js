export default {
	save() {
		let components = ProjectComponentCart.cartData();
		let projectID = components.length > 0 ? components[0].projectid : -1;
		
		components.map(item => {
			//Add component to project
			AddComponentToProject.run({
				projectid:projectID,
				componentid:item.componentId,
				quantity:item.quantity
			});
		});
		showAlert(components.length + ' Components added to the project.', 'success')
		return true;
	}
}