package com.techelevator.controller;

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

import com.techelevator.dao.CommentDAO;

import com.techelevator.model.CommentDTO;
@CrossOrigin
@RestController
public class CommentController {
	
	private CommentDAO commentDAO;
		
	public CommentController(CommentDAO commentDAO) {
		this.commentDAO = commentDAO;
	}
	
	//Get all comments
	@RequestMapping(path = "/comments", method = RequestMethod.GET)
	public List<CommentDTO> getAllComments() {
		return commentDAO.getAllComments();
	}
	
	//Get comments by user
	@RequestMapping(path = "/comments/user/{username}", method = RequestMethod.GET)
	public List<CommentDTO> getCommentsByUserId(@PathVariable String username) {
		return commentDAO.getCommentsByUsername(username);
	}
	
	//Get comments by pothole
	@RequestMapping(path = "/comments/pothole/{potholeId}", method = RequestMethod.GET)
	public List<CommentDTO> getCommentsByPotholeId(@PathVariable Long potholeId) {
		return commentDAO.getCommentsByPotholeId(potholeId);
	}
	
	//Add comments
	@ResponseStatus(HttpStatus.CREATED)
	@RequestMapping(path = "/comments", method = RequestMethod.POST)
	public void createComment(@Valid @RequestBody CommentDTO newComment) {
		commentDAO.createComment(newComment);
	}
	
	//Delete comment
	@RequestMapping(path = "/comments/{id}", method = RequestMethod.DELETE)
	public void deleteComment(@PathVariable Long id) {
		commentDAO.deleteComment(id);
	}
}
