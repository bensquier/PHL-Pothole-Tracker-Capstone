//package com.techelevator.controller;
//
//import java.util.List;
//
//import javax.validation.Valid;
//
//import org.springframework.http.HttpStatus;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseStatus;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.techelevator.dao.LocationDAO;
//import com.techelevator.model.Location;
//import com.techelevator.model.PotholeDTO;
//
//@RestController
//public class LocationController {
//	
//	private LocationDAO locationDAO;
//
//	public LocationController(LocationDAO locationDAO) {
//		this.locationDAO = locationDAO;
//	}
	
	//Get all pothole locations
//	@RequestMapping(path = "/locations", method = RequestMethod.GET)
//	public List<Location> listAllLocations() {
//		return locationDAO.getAllPotholeLocations();
//	}
	
	//Add pothole location
//	@ResponseStatus(HttpStatus.CREATED)
//	@RequestMapping(path = "/locations", method = RequestMethod.POST)
//	public void createLocation(@Valid @RequestBody PotholeDTO newLocation) {
//		locationDAO.createLocation(newLocation);
//	}
	
	//Update pothole location
//	@RequestMapping(path = "/locations/{id}", method = RequestMethod.PUT)
//	public void updatePotholeLocation(@Valid @RequestBody Location updatedLocation, @PathVariable int id) {
//		locationDAO.updatePotholeLocation(updatedLocation);
//	}
	
	//
//}
