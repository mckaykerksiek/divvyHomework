import  React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { FlatList, Text, StyleSheet, View, Image } from 'react-native';
import { TouchableHighlight } from 'react-native-gesture-handler';

const businessData = require('../data.json');

export default class Businesses extends React.Component {
  navigation = this.props.navigation
  sortedBusinesses = businessData.sort(function(a,b){return a.name.localeCompare(b.name)})
  
  // layout for items in the list
  businessItem = ({item}) => (
    <TouchableHighlight onPress={() => this.navigation.navigate('Profile', { business: item }) }>
    <View style={styles.itemContainer}>
      <Image style={styles.listImage}
          // I just found this image online and copied the link, ideally we would have icons or logos 
          source={{uri: 'https://cdn-icons-png.flaticon.com/512/4689/4689530.png'}}/>
      <View style={{flexDirection: 'column'}, {paddingHorizontal: 12}, {flex: 1}}>
        <Text style={styles.item}> 
          { item.name }
        </Text> 
        <Text style={styles.location}> 
          {item.location.city}, {item.location.country} 
        </Text>
      </View>
      <Image style={styles.icon} source={require('./assets/right-arrow-icon.png')}/>
    </View>
    </TouchableHighlight>
  ) 

  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={this.sortedBusinesses}
          keyExtractor={({ id }) => id.toString()}
          renderItem= {this.businessItem}
        />
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   padding: 8,
  },
  itemContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 10,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: 'lightgray'
  },
  item: {
    flexDirection: 'row',
    fontSize: 24,
    paddingBottom: 2
  },
  location: {
    fontSize: 12,
    color: 'grey'
  },
  listImage: {
    width: 32,
    height: 32,
    margin: 10
  },
  icon: {
    width: 8,
    height: 8,
    padding: 8
  }
});
