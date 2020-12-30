package com.techelevator.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.dao.PotholeDAO;

import com.techelevator.model.PotholeAlreadyExistException;
import com.techelevator.model.PotholeDTO;

@RestController
@CrossOrigin
public class PotholeController {

	private PotholeDAO potholeDAO;

	public PotholeController(PotholeDAO potholeDAO) {
		this.potholeDAO = potholeDAO;
	}

	// Get all potholes
	@RequestMapping(value = "/potholes", method = RequestMethod.GET)
	public List<PotholeDTO> listAllPotholes() {
		return potholeDAO.findAllPotholes();
	}

	// Get pothole by ID
	@RequestMapping(value = "/potholes/{id}", method = RequestMethod.GET)
	public PotholeDTO getPothole(@PathVariable int id) {
		return potholeDAO.getPotholeById(id);
	}

	// Get pothole by Status
	@RequestMapping(value = "/potholes/status/{status}", method = RequestMethod.GET)
	public List<PotholeDTO> getPotholeByStatus(@PathVariable String status) {
		return potholeDAO.getPotholesByStatus(status);
	}

	// Add pothole
	@ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(value = "/potholes", method = RequestMethod.POST)
	public void addPothole(@Valid @RequestBody PotholeDTO newPothole) {
		BigDecimal range = new BigDecimal(.00001);
		BigDecimal currentLat = newPothole.getLatitude().setScale(5, RoundingMode.UP);
		BigDecimal currentLng = newPothole.getLongitude().setScale(5, RoundingMode.UP);
		
		newPothole.setLatitude(currentLat);
		newPothole.setLongitude(currentLng);
		
		PotholeDTO potholePlusLat = new PotholeDTO(newPothole.getSeverity(), currentLat.add(range).setScale(5, RoundingMode.HALF_UP), currentLng);
		PotholeDTO potholeMinusLat = new PotholeDTO(newPothole.getSeverity(), currentLat.subtract(range).setScale(5, RoundingMode.HALF_UP), currentLng);
		PotholeDTO potholePlusLng = new PotholeDTO(newPothole.getSeverity(), currentLat, currentLng.add(range).setScale(5, RoundingMode.HALF_UP));
		PotholeDTO potholeMinusLng = new PotholeDTO(newPothole.getSeverity(), currentLat, currentLng.subtract(range).setScale(5, RoundingMode.HALF_UP));
		PotholeDTO potholePlusBoth = new PotholeDTO(newPothole.getSeverity(), currentLat.add(range).setScale(5, RoundingMode.HALF_UP), currentLng.add(range).setScale(5, RoundingMode.HALF_UP));
		PotholeDTO potholeMinusBoth = new PotholeDTO(newPothole.getSeverity(), currentLat.subtract(range).setScale(5, RoundingMode.HALF_UP), currentLng.subtract(range).setScale(5, RoundingMode.HALF_UP));
		PotholeDTO potholePlusLatMinusLng = new PotholeDTO(newPothole.getSeverity(), currentLat.add(range).setScale(5, RoundingMode.HALF_UP), currentLng.subtract(range).setScale(5, RoundingMode.HALF_UP));
		PotholeDTO potholeMinusLatPlusLng = new PotholeDTO(newPothole.getSeverity(), currentLat.subtract(range).setScale(5, RoundingMode.HALF_UP), currentLng.add(range).setScale(5, RoundingMode.HALF_UP));
		
		PotholeDTO pothole1 = potholeDAO.getPotholeByLatLng(newPothole);
		PotholeDTO pothole2  = potholeDAO.getPotholeByLatLng(potholePlusLat);
		PotholeDTO pothole3  = potholeDAO.getPotholeByLatLng(potholeMinusLat);
		PotholeDTO pothole4  = potholeDAO.getPotholeByLatLng(potholePlusLng);
		PotholeDTO pothole5  = potholeDAO.getPotholeByLatLng(potholeMinusLng);
		PotholeDTO pothole6  = potholeDAO.getPotholeByLatLng(potholePlusBoth);
		PotholeDTO pothole7  = potholeDAO.getPotholeByLatLng(potholeMinusBoth);
		PotholeDTO pothole8  = potholeDAO.getPotholeByLatLng(potholePlusLatMinusLng);
		PotholeDTO pothole9  = potholeDAO.getPotholeByLatLng(potholeMinusLatPlusLng);

		if(pothole1 != null || pothole2 != null || pothole3 != null || pothole4 != null || pothole5 != null || pothole6 != null 
				|| pothole7 != null || pothole8 !=null || pothole9 != null) {
			throw new PotholeAlreadyExistException();

		} else {
			potholeDAO.createPothole(newPothole);
		}
	}

	// Update pothole
	@RequestMapping(value = "/potholes/{potholeId}", method = RequestMethod.PUT)
	public void updatePothole(@Valid @RequestBody PotholeDTO updatedPothole, @PathVariable int potholeId) {
		potholeDAO.updatePothole(updatedPothole, potholeId);
	}

	// Update pothole severity
	@RequestMapping(value = "/potholes/{potholeId}/severity", method = RequestMethod.PUT)
	public void updatePotholeSeverity(@Valid @RequestBody PotholeDTO updatedPothole, @PathVariable int potholeId) {
		potholeDAO.updatePotholeSeverity(potholeId, updatedPothole);
	}

	// Update pothole status
	@RequestMapping(value = "/potholes/{potholeId}/status", method = RequestMethod.PUT)
	public void updatePotholeStatus(@Valid @RequestBody PotholeDTO updatedPothole, @PathVariable int potholeId) {
		potholeDAO.updatePotholeStatus(potholeId, updatedPothole);
	}

	// Delete pothole Might not use may just changed status to deleted
	@ResponseStatus(HttpStatus.OK)
	@RequestMapping(value = "/potholes/{potholeId}", method = RequestMethod.DELETE)
	public void deletelPothole(@PathVariable int potholeId) {
		potholeDAO.deletePothole(potholeId);
	}
}
