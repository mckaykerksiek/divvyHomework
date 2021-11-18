import  React, { useEffect, useState } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { FlatList, Text, StyleSheet, View } from 'react-native';

const companiesData = require('../data.json');

export default class Businesses extends React.Component {
  state = {isLoading: false}
  

  render() {
    return (
    <View style={styles.container}>
      <FlatList
        data={companiesData}
        keyExtractor={({ id }) => id.toString()}
        renderItem={({item}) => <Text style={styles.item}>{item.name}</Text>}
      />
    </View>
    )
    // return <FlatList />
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 22
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },
});
