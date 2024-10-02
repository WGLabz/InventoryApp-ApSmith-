export default {
	save() {
		let orderData = OrderData.orderDetails;
		AddOrder.run().then(res => {
			let orderId = res.length > 0 ? res[0].order_id : -1;
			console.log(orderData)
			orderData.map(item => {
				//Create Order
				AddComponentStock.run({
					orderid: orderId,
					componentid: item.componentId,
					quantity: item.quantity,
					unitcost: item.peritemcost
				})
			});
			showAlert(orderData.length + ' components added to DB.', 'success')
			OrderData.orderData();
			Vendor.setSelectedOption('')
		});
		return true;
	}
}