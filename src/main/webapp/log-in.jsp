<%@page import="ShopHavenmodelDao.cart"%>
<%@page import="java.util.*"%>
<%@page import="ShopHavenmodel.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User auth = (User)request.getSession().getAttribute("auth");
    if(auth!=null){
        response.sendRedirect("index.jsp");
        ArrayList<cart>cart_List=(ArrayList<cart>)session.getAttribute("cart-list");
        if(cart_List !=null){
            request.setAttribute("cart_list", cart_List);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopHaven Log-in Page</title>
    <%@ include file="includes/head.jsp" %>
    <style>
        :root {
            --primary-color: #6a5acd; /* ShopHaven purple */
            --secondary-color: #ff7e5f; /* Coral accent */
            --dark-color: #2b2d42;
            --light-color: #f8f9fa;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8eb 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        
        /* Animated background */
        @keyframes gradientAnimation {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }
        
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(106, 90, 205, 0.1), rgba(255, 126, 95, 0.1), rgba(106, 90, 205, 0.1));
            background-size: 400% 400%;
            animation: gradientAnimation 15s ease infinite;
            z-index: -1;
        }
        
        /* Floating shapes animation */
        .floating-shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
            opacity: 0.7;
        }
        
        .shape {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            opacity: 0.15;
            animation: floatAnimation 15s infinite linear;
        }
        
        @keyframes floatAnimation {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 0.15;
            }
            50% {
                transform: translateY(-100px) rotate(180deg);
                opacity: 0.2;
            }
            100% {
                transform: translateY(0) rotate(360deg);
                opacity: 0.15;
            }
        }
        
        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
            position: relative;
        }
        
        .login-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.4s ease;
            max-width: 500px;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            animation: cardAppear 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            opacity: 0;
            transform: translateY(30px) scale(0.95);
        }
        
        @keyframes cardAppear {
            0% {
                opacity: 0;
                transform: translateY(30px) scale(0.95);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        .login-card:hover {
            transform: translateY(-10px) scale(1.01);
            box-shadow: 0 20px 40px rgba(106, 90, 205, 0.2);
        }
        
        .card-header {
            background: var(--primary-color);
            color: white;
            text-align: center;
            padding: 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                to bottom right,
                rgba(255,255,255,0.3) 0%,
                rgba(255,255,255,0) 60%
            );
            transform: rotate(30deg);
            pointer-events: none;
            animation: shimmer 3s infinite linear;
        }
        
        @keyframes shimmer {
            0% {
                transform: rotate(30deg) translateX(-50%);
            }
            100% {
                transform: rotate(30deg) translateX(100%);
            }
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
            overflow: hidden;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            opacity: 0;
            transform: translateY(20px);
            background: rgba(255, 255, 255, 0.9);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(106, 90, 205, 0.2);
            transform: translateY(0);
        }
        
        /* Input field ripple effect */
        .form-group::after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(106, 90, 205, 0.3);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1);
            transition: 0.6s;
            z-index: -1;
        }
        
        .form-group:focus-within::after {
            opacity: 1;
            transform: scale(150);
        }
        
        .login-btn {
            background: var(--primary-color);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            width: 100%;
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .login-btn:hover {
            background: #5a4acd;
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 10px 20px rgba(106, 90, 205, 0.4);
        }
        
        .login-btn::after {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.2),
                transparent
            );
            transition: 0.5s;
        }
        
        .login-btn:hover::after {
            left: 100%;
        }
        
        /* Button pulse animation */
        @keyframes buttonPulse {
            0% {
                box-shadow: 0 0 0 0 rgba(106, 90, 205, 0.6);
            }
            70% {
                box-shadow: 0 0 0 15px rgba(106, 90, 205, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(106, 90, 205, 0);
            }
        }
        
        .login-btn:focus {
            animation: buttonPulse 1.5s infinite;
        }
        
        .alternative-login {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease 0.3s;
        }
        
        .social-login {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease 0.4s;
        }
        
        .social-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }
        
        /* Social button hover effect */
        .social-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: scale(0);
            transition: 0.3s;
        }
        
        .social-btn:hover::before {
            transform: scale(1);
        }
        
        .social-btn:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
        }
        
        .google-btn {
            background: #DB4437;
        }
        
        .facebook-btn {
            background: #4267B2;
        }
        
        .forgot-password {
            text-align: right;
            margin-top: -0.5rem;
            margin-bottom: 1.5rem;
            opacity: 0;
            transform: translateX(20px);
            transition: all 0.4s ease 0.2s;
        }
        
        .forgot-password a {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            position: relative;
        }
        
        /* Link underline animation */
        .forgot-password a::after,
        .register-link a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: var(--primary-color);
            transition: width 0.3s ease;
        }
        
        .forgot-password a:hover::after,
        .register-link a:hover::after {
            width: 100%;
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease 0.5s;
        }
        
        .register-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            position: relative;
        }
        
        .floating-label {
            position: absolute;
            top: 12px;
            left: 15px;
            color: #6c757d;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            pointer-events: none;
            background: transparent;
            padding: 0 5px;
        }
        
        .form-control:focus + .floating-label,
        .form-control:not(:placeholder-shown) + .floating-label {
            top: -10px;
            left: 10px;
            font-size: 0.8rem;
            color: var(--primary-color);
            background: white;
            font-weight: 600;
            padding: 0 5px;
        }
        
        .brand-logo {
            text-align: center;
            margin-bottom: 1.5rem;
            opacity: 0;
            transform: scale(0.8);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .brand-logo svg {
            filter: drop-shadow(0 4px 6px rgba(106, 90, 205, 0.3));
            transition: all 0.4s ease;
        }
        
        .brand-logo:hover svg {
            transform: scale(1.1) rotate(5deg);
            filter: drop-shadow(0 8px 15px rgba(106, 90, 205, 0.5));
        }
        
        /* SVG Logo Animation */
        @keyframes logoFloat {
            0% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0);
            }
        }
        
        .brand-logo svg {
            animation: logoFloat 3s ease-in-out infinite;
        }
        
        /* Error shake animation */
        @keyframes shake {
            0%, 100% {transform: translateX(0);}
            10%, 30%, 50%, 70%, 90% {transform: translateX(-5px);}
            20%, 40%, 60%, 80% {transform: translateX(5px);}
        }
        
        .error-shake {
            animation: shake 0.6s;
        }
        
        /* Loading animation */
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -10px;
            margin-left: -10px;
        }
        
        /* Success checkmark animation */
        .checkmark {
            width: 20px;
            height: 20px;
            stroke-width: 2;
            stroke: white;
            stroke-miterlimit: 10;
            stroke-dasharray: 30;
            stroke-dashoffset: 30;
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -10px;
            margin-left: -10px;
        }
        
        @keyframes draw {
            to {
                stroke-dashoffset: 0;
            }
        }
        
        .activated .checkmark {
            display: block;
            animation: draw 0.5s ease forwards 0.3s;
        }
        
        /* Subtle cursor effect */
        .custom-cursor {
            width: 30px;
            height: 30px;
            border: 2px solid var(--primary-color);
            border-radius: 50%;
            position: fixed;
            pointer-events: none;
            transform: translate(-50%, -50%);
            z-index: 9999;
            opacity: 0;
            transition: width 0.2s, height 0.2s, opacity 0.2s;
            mix-blend-mode: difference;
        }
        
        .card-appear {
            opacity: 1 !important;
            transform: translateY(0) scale(1) !important;
        }
        
        .item-appear {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }
    </style>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    
    <div class="custom-cursor"></div>
    
    <div class="floating-shapes">
        <div class="shape" style="top: 5%; left: 10%; width: 100px; height: 100px; animation-delay: 0s;"></div>
        <div class="shape" style="top: 15%; left: 30%; width: 70px; height: 70px; animation-delay: 1s;"></div>
        <div class="shape" style="top: 25%; left: 60%; width: 120px; height: 120px; animation-delay: 2s;"></div>
        <div class="shape" style="top: 60%; left: 80%; width: 80px; height: 80px; animation-delay: 3s;"></div>
        <div class="shape" style="top: 70%; left: 20%; width: 90px; height: 90px; animation-delay: 4s;"></div>
        <div class="shape" style="top: 80%; left: 50%; width: 110px; height: 110px; animation-delay: 5s;"></div>
    </div>
    
    <div class="login-container">
        <div class="login-card">
            <div class="card-header">
                Welcome Back to ShopHaven
            </div>
            <div class="card-body">
                <div class="brand-logo">
                    <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2L3 7L12 12L21 7L12 2Z" fill="#6a5acd"/>
                        <path d="M3 11L12 16L21 11" stroke="#6a5acd" stroke-width="2" stroke-linecap="round"/>
                        <path d="M3 15L12 20L21 15" stroke="#6a5acd" stroke-width="2" stroke-linecap="round"/>
                    </svg>
                </div>
                
                <form id="login-form" action="user-login" method="post">
                    <div class="form-group">
                        <input type="email" class="form-control" id="login-email" name="login-email" placeholder=" " required>
                        <label for="login-email" class="floating-label">Email Address</label>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" class="form-control" id="login-password" name="login-password" placeholder=" " required>
                        <label for="login-password" class="floating-label">Password</label>
                    </div>
                    
                    <div class="forgot-password">
                        <a href="forgot-password.jsp">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-primary login-btn">
                        <span class="btn-text">Sign In</span>
                        <div class="loading-spinner"></div>
                        <svg class="checkmark" viewBox="0 0 24 24">
                            <path d="M5 13l4 4L19 7" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                    
                    <div class="alternative-login">
                        <small>Or sign in with</small>
                    </div>
                    
                    <div class="social-login">
                        <a href="#" class="social-btn google-btn">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-btn facebook-btn">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                    </div>
                    
                    <div class="register-link">
                        <small>Don't have an account? <a href="register.jsp">Register here</a></small>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <%@ include file="includes/footer.jsp" %>
    
    <script>
        // Add animation to form inputs when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Animate card appearance
            setTimeout(() => {
                document.querySelector('.login-card').classList.add('card-appear');
            }, 200);
            
            // Animate logo appearance
            setTimeout(() => {
                document.querySelector('.brand-logo').classList.add('item-appear');
            }, 500);
            
            // Animate form inputs appearance
            const inputs = document.querySelectorAll('.form-control');
            inputs.forEach((input, index) => {
                setTimeout(() => {
                    input.classList.add('item-appear');
                }, 700 + index * 150);
            });
            
            // Animate forgotten password link appearance
            setTimeout(() => {
                document.querySelector('.forgot-password').classList.add('item-appear');
            }, 1000);
            
            // Animate button appearance
            setTimeout(() => {
                document.querySelector('.login-btn').classList.add('item-appear');
            }, 1200);
            
            // Animate alternative login text appearance
            setTimeout(() => {
                document.querySelector('.alternative-login').classList.add('item-appear');
            }, 1300);
            
            // Animate social login buttons appearance
            setTimeout(() => {
                document.querySelector('.social-login').classList.add('item-appear');
            }, 1400);
            
            // Animate register link appearance
            setTimeout(() => {
                document.querySelector('.register-link').classList.add('item-appear');
            }, 1500);
            
            // Custom cursor effect for interactive elements
            const cursor = document.querySelector('.custom-cursor');
            const interactiveElements = document.querySelectorAll('a, button, input, .login-card');
            
            document.addEventListener('mousemove', (e) => {
                cursor.style.left = e.clientX + 'px';
                cursor.style.top = e.clientY + 'px';
            });
            
            interactiveElements.forEach(el => {
                el.addEventListener('mouseenter', () => {
                    cursor.style.opacity = '1';
                    cursor.style.width = '40px';
                    cursor.style.height = '40px';
                    cursor.style.borderColor = 'var(--primary-color)';
                });
                
                el.addEventListener('mouseleave', () => {
                    cursor.style.opacity = '0';
                    cursor.style.width = '30px';
                    cursor.style.height = '30px';
                });
            });
            
            // Form submission animation
            document.getElementById('login-form').addEventListener('submit', function(e) {
                const loginBtn = document.querySelector('.login-btn');
                const btnText = loginBtn.querySelector('.btn-text');
                const spinner = loginBtn.querySelector('.loading-spinner');
                
                // Check if form is valid before showing animation
                if (this.checkValidity()) {
                    e.preventDefault(); // Prevent form submission for demonstration
                    
                    // Show loading animation
                    btnText.style.opacity = '0';
                    spinner.style.display = 'block';
                    
                    // Simulate loading for demonstration (replace with actual form submission in production)
                    setTimeout(() => {
                        spinner.style.display = 'none';
                        loginBtn.classList.add('activated');
                        
                        // Redirect or handle successful login after animation
                        setTimeout(() => {
                            this.submit(); // Submit the form after animation
                        }, 1000);
                    }, 2000);
                }
            });
            
            // Validation error animation
            const formInputs = document.querySelectorAll('.form-control');
            formInputs.forEach(input => {
                input.addEventListener('invalid', function(e) {
                    input.parentElement.classList.add('error-shake');
                    setTimeout(() => {
                        input.parentElement.classList.remove('error-shake');
                    }, 600);
                });
            });
            
            // Ripple effect for buttons
            const buttons = document.querySelectorAll('.login-btn, .social-btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    const x = e.clientX - e.target.getBoundingClientRect().left;
                    const y = e.clientY - e.target.getBoundingClientRect().top;
                    
                    const ripple = document.createElement('span');
                    ripple.style.position = 'absolute';
                    ripple.style.width = '1px';
                    ripple.style.height = '1px';
                    ripple.style.borderRadius = '50%';
                    ripple.style.backgroundColor = 'rgba(255, 255, 255, 0.7)';
                    ripple.style.transform = 'scale(0)';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.style.animation = 'ripple 0.6s linear';
                    
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
            
            // Add ripple animation definition
            const style = document.createElement('style');
            style.innerHTML = `
                @keyframes ripple {
                    to {
                        transform: scale(100);
                        opacity: 0;
                    }
                }
            `;
            document.head.appendChild(style);
        });
    </script>
</body>


</html>