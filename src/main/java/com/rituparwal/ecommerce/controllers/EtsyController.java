package com.rituparwal.ecommerce.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.rituparwal.ecommerce.models.ClientOrder;
import com.rituparwal.ecommerce.models.OrderProduct;
import com.rituparwal.ecommerce.models.Product;
import com.rituparwal.ecommerce.models.Store;
import com.rituparwal.ecommerce.models.User;
import com.rituparwal.ecommerce.services.EtsyService;
import com.rituparwal.ecommerce.validator.UserValidator;


@Controller
public class EtsyController {
	private final EtsyService etsyService;
	
	private final UserValidator userValidator;
	
	public EtsyController(EtsyService etsyService, UserValidator userValidator) {
		this.etsyService = etsyService;
		this.userValidator = userValidator;
	}

    @RequestMapping("/registration")
    public String registerForm(@ModelAttribute("user") User user) {
        return "reg.jsp";
    }
    @RequestMapping("/login")
    public String login() {
        return "login.jsp";
    }
    
    @RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
    	userValidator.validate(user, result);
    	if(result.hasErrors()) {
			return "reg.jsp";
		}
		User u = etsyService.registerUser(user);
		session.setAttribute("userId", u.getId());
		return "redirect:/home";
    }
    
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		boolean isAuthenticated = etsyService.authenticateUser(email, password);
		if(isAuthenticated) {
			User u = etsyService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			List<ClientOrder> basket = etsyService.findActive();
			if(basket.size()>0 && basket.get(0).getUser() == u) {
				session.setAttribute("clientOrderId", basket.get(0).getId());
				System.out.println(basket.get(0));
			} else {
				return "redirect:/newBasket";
			}
			
			return "redirect:/home";
		}
		else {
			model.addAttribute("error", "Invalid Credentials! Please try again.");
			return "login.jsp";	
		}
    }
    
    @RequestMapping("/")
    public String index() {
    	return "home.jsp";
    }
    
    @RequestMapping("/home")
    public String home(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		return "home1.jsp";
    }
    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
    		session.invalidate();
    		return "redirect:/";
    }
    
	@GetMapping("/product/new")
	public String newProduct(@Valid @ModelAttribute("productobj") Product product, BindingResult result, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		model.addAttribute("stores", etsyService.allStores());
		return "newprod.jsp";
	}
    
	@PostMapping("/addproduct")
	public String addProduct(@Valid @ModelAttribute("product") Product product, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "newproduct.jsp";
		}
		else {
			etsyService.addProduct(product);
			return "redirect:/products";	
		}	
	}
	
	@GetMapping("/store/new")
	public String newStore(@Valid @ModelAttribute("storeobj") Store store, BindingResult result, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		return "newstore.jsp";
	}
	@PostMapping("/addstore")
	public String addStore(@Valid @ModelAttribute("store") Store store, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "newstore.jsp";
		}
		else {
			etsyService.addStore(store);
			return "redirect:/home";	
		}	
	}
    @RequestMapping("/search/{product}")
	public String search(@PathVariable("product") String product, Model model) {
		List<Product> products = etsyService.getSearchProducts(product);
		model.addAttribute("products", products);
		return "search.jsp";
	}
	@PostMapping("/search")
	public String search(@RequestParam("product") String product) {
		return "redirect:/search/"+product;
	}
	
	@RequestMapping("/products")
	public String allProds(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		Iterable<Product> products = etsyService.allProducts();
		model.addAttribute("products", products);
		return "allproduct.jsp";
	}
    
    @RequestMapping("/products/{id}")
    public String getOneProduct(@PathVariable("id") Long id, Model model, @ModelAttribute("productModel") Product productModel, HttpSession session){
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
    	Store store = etsyService.findStoreById(id);
    	model.addAttribute("store", store);
    	Product product = etsyService.findProductById(id);
        model.addAttribute("product", product);
        return "oneprod.jsp";
    }
    
    @GetMapping("/stores/{id}")
    public String getOneStore(@PathVariable("id") Long id, Model model, @ModelAttribute("storeModel") Store storeModel, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
    	Store store = etsyService.findStoreById(id);
    	model.addAttribute("store", store);
    	Product product = etsyService.findProductById(id);
        model.addAttribute("product", product);
    	return "onestore.jsp";
    	
    }
    @RequestMapping("/products/category/{category}")
	public String categories(@PathVariable("category") String product, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
    	List<Product> products = etsyService.getCategoryProducts(product);
		model.addAttribute("products", products);
		return "category.jsp";
	}
    
	@RequestMapping("/newBasket")
	public String newBasket(HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User user = etsyService.findUserById(userId);
		ClientOrder clientOrder = new ClientOrder();
		clientOrder.setUser(user);
		ClientOrder thisClientOrder = etsyService.save(clientOrder);
		session.setAttribute("clientOrderId", thisClientOrder.getId());
		return "redirect:/home";
	}
	
	@RequestMapping(value="/addToBasket/{id}", method=RequestMethod.POST)
	public String addToBasket(@PathVariable("id") long id,HttpSession session,@ModelAttribute("orderProduct") OrderProduct orderProduct) {
//		find product with id
		OrderProduct newOrder = new OrderProduct();
		Product product = etsyService.findProductById(id);
//		get client order
		
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		System.out.println("Client Order Id" + clientOrderId);
		ClientOrder clientOrder;
		Long userId = (Long) session.getAttribute("userId");
		if (clientOrderId == null) {
			User user = etsyService.findUserById(userId);
			clientOrder = new ClientOrder();
			clientOrder.setUser(user);
			ClientOrder thisClientOrder = etsyService.save(clientOrder);
			session.setAttribute("clientOrderId", thisClientOrder.getId());
		} else {
			clientOrder = etsyService.findClientOrderById(clientOrderId);
		}
//		set client order and product to orderProduct and save
		newOrder.setClientOrder(clientOrder);
		newOrder.setProduct(product);
		newOrder.setQuantity(orderProduct.getQuantity());
		etsyService.save(newOrder);
		return "redirect:/home";
	}
	@RequestMapping("/removeFromBasket/{id}")
	public String removeFromBasket(@PathVariable("id") long id, HttpSession session) {
//		Delete Order Product
		etsyService.deleteOrderProduct(id);
		
//		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
//		ClientOrder clientOrder = clientOrderService.findById(clientOrderId);
		
		
		return "redirect:/basket";
	}
	@RequestMapping("/basket")
	public String checkBasket(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		if(clientOrderId != null) {			
			ClientOrder clientOrder = etsyService.findClientOrderById(clientOrderId);
			model.addAttribute("clientOrder", clientOrder);
		}
		return "basket.jsp";
	}
	@RequestMapping("/deleteBasket")
	public String deleteBasket(HttpSession session) {
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		etsyService.deleteClientOrder(clientOrderId);
		return "redirect:/newBasket";
	}
	@RequestMapping("/allOrders")
	public String allOrders(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User user = etsyService.findUserById(userId);
		model.addAttribute("user", user);
		List<ClientOrder> clientOrders = user.getClientOrders();
		model.addAttribute("clientOrders", clientOrders);
		return "orderHistory.jsp";
	}
	@RequestMapping("/clientOrder/{id}")
	public String showClientOrder(@PathVariable("id") long id,Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
		ClientOrder clientOrder = etsyService.findClientOrderById(id);
		model.addAttribute("clientOrder", clientOrder);
		return "show.jsp";
	}
	@RequestMapping("/checkoutBasket")
	public String checkoutBasket(HttpSession session, RedirectAttributes attributes) {
		Long clientOrderId = (Long) session.getAttribute("clientOrderId");
		ClientOrder clientOrder = etsyService.findClientOrderById(clientOrderId);
		
		if (clientOrder.getOrderProducts().size()<1) {
			attributes.addFlashAttribute("emptyMessage", "Cannot checkout an empty basket");
			return "redirect:/basket";
		} else {			
			clientOrder.setCheckedOut(true);
			etsyService.save(clientOrder);
			return "redirect:/newBasket";
		}
	}
    @RequestMapping("/products/delete/{id}")
    public String destroy(@PathVariable("id") Long id) {
        etsyService.deleteProduct(id);
        return "redirect:/products";
    }
    
    @RequestMapping("/products/edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
    	Product product = etsyService.findProductById(id);
    	model.addAttribute("product", product);
    	model.addAttribute("stores", etsyService.allStores());
        return "edit.jsp";
    }
    
    @RequestMapping(value="/products/edit/{id}", method=RequestMethod.PUT)
    public String update(@Valid @ModelAttribute("product") Product product, BindingResult result) {
        if (result.hasErrors()) {
            return "edit.jsp";
        } else {
            etsyService.updateProduct(product);
            return "redirect:/products";
        }
    }
    @RequestMapping("/stores/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        etsyService.deleteStore(id);
        return "redirect:/products";
    }
    
    @RequestMapping("/stores/edit/{id}")
    public String editStore(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = etsyService.findUserById(userId);
		model.addAttribute("user", u);
    	Store store = etsyService.findStoreById(id);
    	model.addAttribute("store", store);
        return "editstore.jsp";
    }
    
    @RequestMapping(value="/stores/edit/{id}", method=RequestMethod.PUT)
    public String updateStpre(@Valid @ModelAttribute("store") Store store, BindingResult result) {
        if (result.hasErrors()) {
            return "editstore.jsp";
        } else {
            etsyService.updateStore(store);
            return "redirect:/products";
        }
    }
}
