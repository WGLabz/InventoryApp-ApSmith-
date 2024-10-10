export default {
	async save() {
		let components = ProjectComponentCart.cartData();
		let projectID = components.length > 0 ? components[0].projectid : -1;

		components.map(async (item) => {
			//Add component to project
			await	AddComponentToProject.run({
				projectid:projectID,
				componentid:item.componentId,
				quantity:item.quantity
			});
		});

		// Clear the cart
		ProjectComponentCart.clearCart();
		closeModal(ProectBOMModal.name);

		showAlert(components.length + ' Components added to the project.', 'success');
		return true;
	}
}