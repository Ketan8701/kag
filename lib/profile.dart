import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            title: Text('Matilda Brown'),
            subtitle: Text('matildabrown@mail.com'),
          ),
          ListTile(
            title: Text('My orders'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Shipping addresses'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to shipping addresses screen
            },
          ),
          ListTile(
            title: Text('Payment methods'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to payment methods screen
            },
          ),
          ListTile(
            title: Text('Promocodes'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to promocodes screen
            },
          ),
          ListTile(
            title: Text('My reviews'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to my reviews screen
            },
          ),
          ListTile(
            title: Text('Settings'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
    );
  }
}

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.check),
                title: Text('Order No1947034'),
                subtitle: Text('Tracking number: IW3475453455'),
              ),
              ListTile(
                leading: Icon(Icons.details),
                title: Text('Order Details'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailsScreen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Order information'),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Delivery method:'),
          ),
          ListTile(
            leading: Icon(Icons.discount),
            title: Text('Discount:'),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Total Amount: \$112'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment method:'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Pullover Mango'),
            subtitle: Text('Color: Gray, Units: 1'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Pullover Mango'),
            subtitle: Text('Color: Gray, Units: 1'),
          ),
        ],
      ),
    );
  }
}
