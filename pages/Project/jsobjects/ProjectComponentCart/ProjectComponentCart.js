export default {
	cart: [],
	clearCart(){
		this.cart = [];
		showAlert('Cart cleared','success');
		this.cartData();
	},
	addToCart () {
		var componentName = ComponentSelect.selectedOptionLabel;
		var componentId = ComponentSelect.selectedOptionValue;
		var quantity = Number(Input1Copy2.text);
		var image = Image1.image;
		var projectID = appsmith.URL.queryParams.id;

		this.cart.push({
			projectid: projectID,
			id: this.cart.length + 1,
			componentId: componentId,
			component: componentName,
			image:image,
			quantity: quantity
		});
		showAlert('Item cached for the project','success');
		this.cartData();
		return true;
	},
	removeFromOrder () {
		let id = ProjectCartTable.selectedRow.id;
		this.cart = this.cart.filter( o => {
			return o.id !== id;
		})
		showAlert('Item removed from the project cart','success')
		this.cartData();
	},
	cartData(){
		if(this.cart.length > 0)
			return this.cart;
		else{
			return [{
				projectid: '',
				id: 1,
				componentId: '',
				component: '',
				image:'',
				quantity: ''
			}]
		}
	}
}