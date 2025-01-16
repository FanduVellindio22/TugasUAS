import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ThrillerScreen extends StatefulWidget {
  @override
  _ThrillerSScreenState createState() => _ThrillerSScreenState();
}

class _ThrillerSScreenState extends State<ThrillerScreen> {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  TextEditingController _searchController = TextEditingController();

  Future<List<dynamic>> _fetchData() async {
    final url = Uri.parse('http://teknologi22.xyz/project_api/api_fandu/api_thriller.php?action=get');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Raw response: ${response.body}');
      try {
        final rawData = json.decode(response.body);
        final data = rawData['data'];
        return data;
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception('Failed to decode JSON');
      }
    } else {
      print('Error fetching data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _deleteData(String id) async {
    final url = Uri.parse(
        'https://teknologi22.xyz/project_api/api_fandu/api_thriller.php?action=delete&id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {}); // Refresh the data after deletion
    } else {
      print('Failed to delete data');
    }
  }

  void _addOrUpdateData(String? id, [dynamic existingItem]) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    if (existingItem != null) {
      nameController.text = existingItem['nama'];
      descController.text = existingItem['deskripsi'];
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Data' : 'Update Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final url = Uri.parse(
                  'https://teknologi22.xyz/project_api/api_fandu/api_thriller.php?action=${id == null ? 'add' : 'update'}');
              final response = await http.post(url, body: {
                'id': id ?? '',
                'nama': nameController.text,
                'deskripsi': descController.text,
              });

              if (response.statusCode == 200) {
                // Refresh data after adding or updating
                _fetchData().then((fetchedData) {
                  setState(() {
                    data = fetchedData;
                    filteredData = data;
                  });
                });

                Navigator.pop(context);
              } else {
                print('Failed to ${id == null ? 'add' : 'update'} data');
              }
            },
            child: Text('Submit'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _searchData(String query) {
    setState(() {
      filteredData = data.where((item) {
        return item['nama'].toLowerCase().contains(query.toLowerCase()) ||
            item['deskripsi'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData().then((fetchedData) {
      setState(() {
        data = fetchedData;
        filteredData = data;
      });
    });

    _searchController.addListener(() {
      _searchData(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thriller Category'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or description...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: filteredData.isEmpty
                  ? Center(child: Text('No data available'))
                  : ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            item['nama'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                          ),
                          subtitle: Text(
                            item['deskripsi'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _addOrUpdateData(item['id'], item),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteData(item['id']),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.white, thickness: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrUpdateData(null),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        tooltip: 'Add New Item',
      ),
    );
  }
}
