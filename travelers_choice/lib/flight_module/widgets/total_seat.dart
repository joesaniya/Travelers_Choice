import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/tab_controller.dart';
import '../../models/ticket_data.dart';

class TotalSeats extends StatelessWidget {
  const TotalSeats({super.key});

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);

    bool? checkBookedTickets(String ticketNumber) {
      switch (ticket.bookingClass) {
        case 'Economy':
          return ticket.economyClassSeatsList.contains(ticketNumber);
          break;
        case 'Business':
          return ticket.businessClassSeatsList.contains(ticketNumber);
          break;
        case 'First':
          return ticket.firstClassSeatsList.contains(ticketNumber);
          break;
        default:
          return null;
      }
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SeatContainer(
                    seatNumber: '${index + 1}A',
                    isBooked: checkBookedTickets('${index + 1}A'),
                  ),
                  const SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}B',
                    isBooked: checkBookedTickets('${index + 1}B'),
                  ),
                  const SizedBox(width: 30.0),
                  SeatContainer(
                    seatNumber: '${index + 1}C',
                    isBooked: checkBookedTickets('${index + 1}C'),
                  ),
                  const SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}D',
                    isBooked: checkBookedTickets('${index + 1}D'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}

class SeatContainer extends StatefulWidget {
  const SeatContainer({super.key, this.isBooked, required this.seatNumber});
  final bool? isBooked;
  final String seatNumber;

  @override
  _SeatContainerState createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  bool isSelected = false;

  void addticket(ticket) {
    isSelected = !isSelected;
    ticket.addSeat(widget.seatNumber);
    ticket.decreaseCount();
    if (ticket.getCount == 0) {
      Provider.of<TabControllerData>(context, listen: false).incrmentIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        switch (ticket.bookingClass) {
          case 'Economy':
            if (ticket.economyClassSeatsList.contains(widget.seatNumber)) {
              // MyAlert.errorAlert(context,
              //     desc: "This seat is already booked. Choose another!");
              log('This seat is already booked. Choose another!');
            } else {
              ticket.economyClassSeatsList.add(widget.seatNumber.toString());
              addticket(ticket);
            }
            break;
          case 'Business':
            if (ticket.businessClassSeatsList.contains(widget.seatNumber)) {
              // MyAlert.errorAlert(context,
              //     desc: "This seat is already booked. Choose another!");
              log('This seat is already booked. Choose anotherff!');
            } else {
              ticket.businessClassSeatsList.add(widget.seatNumber.toString());
              addticket(ticket);
            }
            break;
          case 'First':
            if (ticket.firstClassSeatsList.contains(widget.seatNumber)) {
              log('This seat is already booked. Choose another!');
              // MyAlert.errorAlert(context,
              //     desc: "This seat is already booked. Choose another!");
            } else {
              ticket.firstClassSeatsList.add(widget.seatNumber.toString());
              addticket(ticket);
            }
            break;
        }
      },
      child: Container(
        height: 40.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : const Color(0xFF5B7775),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          border: Border.all(
            color: widget.isBooked == true ? Colors.red : Colors.blue,
          ),
        ),
      ),
    );
  }
}
