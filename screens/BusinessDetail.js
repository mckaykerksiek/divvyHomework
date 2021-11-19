import * as React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import ChartView from './ChartView.js';

export default class BusinessDetail extends React.Component {
  business = this.props.route.params.business
  render() {

    var revenueValues = [77793740.07, 17659305.4, 79457805.93, 12291141.73, 15418844.3, 73533303.23]
    var revenueMonths = ["April", "May", "June", "July", "August", "September"]

    return (
      <View style={styles.container}>
        <View style={styles.container}>
          <Text style={styles.title}> { this.business.name } </Text>
          <Text style={styles.location}> { this.business.location.address}  {this.business.location.city}, {this.business.location.country}</Text>
        </View>
        <ChartView style={{ flex: 1 }} yValues={revenueValues} xValues={revenueMonths}/> 
        
      </View>
    )
  }
  
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   padding: 8,
   backgroundColor: 'white'
  },
  title: {
    fontSize: 32
  },
  location: {
    fontSize: 12,
    color: 'grey'
  },
  listImage: {
    width: 50,
    height: 50
  },
});


